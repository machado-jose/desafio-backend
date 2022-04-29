class AnalyzeExpenseDataService
  def initialize(ide_register:, deputy_expense_list:, create_deputy_service:, add_expense_service:)
    @ide_register = ide_register
    @deputy_expense_list = deputy_expense_list
    @create_deputy_service = create_deputy_service
    @add_expense_service = add_expense_service
  end

  def call
    deputy = Deputy.find_by(ide_register: @ide_register)
    begin
      unless deputy.present?
        deputy = @create_deputy_service.call(
          name: @deputy_expense_list.first["txNomeParlamentar"],
          ide_register: @ide_register,
          deputy_wallet_number: @deputy_expense_list.first["nuCarteiraParlamentar"]
        )
      end
      @deputy_expense_list.each do |deputy_expense_data|
        deputy.add_legislature(
          legislature_number: deputy_expense_data["nuLegislatura"], 
          uf: deputy_expense_data["sgUF"], 
          party_acronym: deputy_expense_data["sgPartido"], 
          legislature_code: deputy_expense_data["codLegislatura"]
        )
        @add_expense_service.call(
          deputy: deputy, 
          legislature_code: deputy_expense_data["codLegislatura"], 
          sub_quota_number: deputy_expense_data["numSubCota"], 
          sub_quota_description: deputy_expense_data["txtDescricao"], 
          sub_quota_specification_number: deputy_expense_data["numEspecificacaoSubCota"], 
          sub_quota_specification_description: deputy_expense_data["txtDescricaoEspecificacao"], 
          provider: deputy_expense_data["txtFornecedor"], 
          provider_registration_number: deputy_expense_data["txtCNPJCPF"], 
          document_number: deputy_expense_data["txtNumero"], 
          document_type: analyze_document_type(document_type: deputy_expense_data["indTipoDocumento"].to_i ), 
          issuance_date: deputy_expense_data["datEmissao"], 
          document_value: deputy_expense_data["vlrDocumento"], 
          reverse_value: deputy_expense_data["vlrGlosa"], 
          net_value: deputy_expense_data["vlrLiquido"], 
          expense_month: deputy_expense_data["numMes"], 
          expense_year: deputy_expense_data["numAno"], 
          installment_number: deputy_expense_data["numParcela"], 
          passager: deputy_expense_data["txtPassageiro"], 
          leg_trip: deputy_expense_data["txtTrecho"], 
          batch_number: deputy_expense_data["numLote"], 
          reimbursement_number: deputy_expense_data["numRessarcimento"], 
          refund_value: deputy_expense_data["vlrRestituicao"], 
          applicant_identifier: deputy_expense_data["ideDocumento"],
          document_url: deputy_expense_data["urlDocumento"]
        )
      end
      deputy.save!
    rescue => e 
      raise ActiveRecord::Rollback
    end
  end

  private
  def analyze_document_type(document_type:)
    # Some lines have document type equal to 4, which is not explained in the documentation
    unless FinancialManagement::DeputyExpense.document_types
                                                .values
                                                .any?{ |doc_type_id| doc_type_id.eql? document_type }
      return 3
    else  
      return document_type
    end
  end
end
