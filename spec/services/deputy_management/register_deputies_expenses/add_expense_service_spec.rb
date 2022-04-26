require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/add_expense_service.rb'

describe 'AddExpenseService' do
  context '#call' do
    before :each do
      @expense_data = {
        "numSubCota" => "122",
        "txtDescricao" => "SERVIÇO DE TÁXI, PEDÁGIO E ESTACIONAMENTO",
        "numEspecificacaoSubCota" => "0",
        "txtDescricaoEspecificacao" => nil,
        "txtFornecedor" => "ASSOCIACAO NACIONAL DE TAXISTAS INFORMATIZADOS ANTAXI",
        "txtCNPJCPF" => "306.059.770/0010-1",
        "txtNumero" => "s/n",
        "indTipoDocumento" => "1",
        "datEmissao" => "2021-10-04T00:00:00",
        "vlrDocumento" => "82",
        "vlrGlosa" => "0",
        "vlrLiquido" => "82",
        "numMes" => "10",
        "numAno" => "2021",
        "numParcela" => "0",
        "txtPassageiro" => nil,
        "txtTrecho" => nil,
        "numLote" => "1805034",
        "numRessarcimento" => nil,
        "vlrRestituicao" => nil,
        "nuDeputadoId" => "2240",
        "ideDocumento" => "7279940",
        "urlDocumento" => "https://www.camara.leg.br/cota-parlamentar/documentos/publ/2240/2021/7279940.pdf"
      }
    end

    it 'Should save deputy expense' do
      deputy = create(:deputy)
      legislature = create(:legislature, deputy: deputy)
      deputy.reload
      expect{
        AddExpenseService.new.call(
          deputy: deputy, 
          legislature_code: legislature.legislature_code, 
          sub_quota_number: @expense_data["numSubCota"], 
          sub_quota_description: @expense_data["txtDescricao"], 
          sub_quota_specification_number: @expense_data["numEspecificacaoSubCota"], 
          sub_quota_specification_description: @expense_data["txtDescricaoEspecificacao"], 
          provider: @expense_data["txtFornecedor"], 
          provider_registration_number: @expense_data["txtCNPJCPF"], 
          document_number: @expense_data["txtNumero"], 
          document_type: @expense_data["indTipoDocumento"], 
          issuance_date: @expense_data["datEmissao"], 
          document_value: @expense_data["vlrDocumento"], 
          reverse_value: @expense_data["vlrGlosa"], 
          net_value: @expense_data["vlrLiquido"], 
          expense_month: @expense_data["numMes"], 
          expense_year: @expense_data["numAno"], 
          installment_number: @expense_data["numParcela"], 
          passager: @expense_data["txtPassageiro"], 
          leg_trip: @expense_data["txtTrecho"], 
          batch_number: @expense_data["numLote"], 
          reimbursement_number: @expense_data["numRessarcimento"], 
          refund_value: @expense_data["vlrRestituicao"], 
          applicant_identifier: @expense_data["ideDocumento"],
          document_url: @expense_data["urlDocumento"]
        )
      }.to change { FinancialManagement::DeputyExpense.count }.by(1)
    end

    context 'Should raise an error' do
      it 'when deputy not have legislature code' do
        deputy = create(:deputy)
        legislature = create(:legislature)
        expect{
          AddExpenseService.new.call(
            deputy: deputy, 
            legislature_code: legislature.legislature_code, 
            sub_quota_number: @expense_data["numSubCota"], 
            sub_quota_description: @expense_data["txtDescricao"], 
            sub_quota_specification_number: @expense_data["numEspecificacaoSubCota"], 
            sub_quota_specification_description: @expense_data["txtDescricaoEspecificacao"], 
            provider: @expense_data["txtFornecedor"], 
            provider_registration_number: @expense_data["txtCNPJCPF"], 
            document_number: @expense_data["txtNumero"], 
            document_type: @expense_data["indTipoDocumento"], 
            issuance_date: @expense_data["datEmissao"], 
            document_value: @expense_data["vlrDocumento"], 
            reverse_value: @expense_data["vlrGlosa"], 
            net_value: @expense_data["vlrLiquido"], 
            expense_month: @expense_data["numMes"], 
            expense_year: @expense_data["numAno"], 
            installment_number: @expense_data["numParcela"], 
            passager: @expense_data["txtPassageiro"], 
            leg_trip: @expense_data["txtTrecho"], 
            batch_number: @expense_data["numLote"], 
            reimbursement_number: @expense_data["numRessarcimento"], 
            refund_value: @expense_data["vlrRestituicao"], 
            applicant_identifier: @expense_data["ideDocumento"],
            document_url: @expense_data["urlDocumento"]
          )
        }.to raise_error(ArgumentError) 
      end
    end
  end
end
