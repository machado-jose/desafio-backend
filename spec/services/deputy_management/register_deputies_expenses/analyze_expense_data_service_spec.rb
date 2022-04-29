require 'rails_helper'
require './app/services/deputy_management/register_deputies_expenses/analyze_expense_data_service.rb'
require './app/services/deputy_management/create_deputy_service.rb'
require './app/services/deputy_management/register_deputies_expenses/add_expense_service.rb'

describe 'AnalyzeExpenseDataService' do
  context '#call' do
    before :each do
      @expense_data = {
          "141405" => [{
            "txNomeParlamentar"=>"Celso Maldaner", 
            "cpf"=>"18270522953", 
            "nuCarteiraParlamentar"=>"472", 
            "nuLegislatura"=>"2019", 
            "sgUF"=>"SC", 
            "sgPartido"=>"MDB", 
            "codLegislatura"=>"56", 
            "numSubCota"=>"120", 
            "txtDescricao"=>"LOCAÇÃO OU FRETAMENTO DE VEÍCULOS AUTOMOTORES", 
            "numEspecificacaoSubCota"=>"0", 
            "txtDescricaoEspecificacao"=>nil, 
            "txtFornecedor"=>"PANTANAL-VEICULOS LTDA", 
            "txtCNPJCPF"=>"073.193.230/0019-1", 
            "txtNumero"=>"20506", 
            "indTipoDocumento"=>"1", 
            "datEmissao"=>"2021-05-31T00:00:00", 
            "vlrDocumento"=>"3500", 
            "vlrGlosa"=>"0", 
            "vlrLiquido"=>"3500", 
            "numMes"=>"5", 
            "numAno"=>"2021", 
            "numParcela"=>"0", 
            "txtPassageiro"=>nil, 
            "txtTrecho"=>nil, 
            "numLote"=>"1771281", 
            "numRessarcimento"=>nil, 
            "vlrRestituicao"=>nil, 
            "nuDeputadoId"=>"1798", 
            "ideDocumento"=>"7206969", 
            "urlDocumento"=>"https://www.camara.leg.br/cota-parlamentar/documentos/publ/1798/2021/7206969.pdf"
            }]
        }
    end

    it 'Should create deputy, legislature and deputy expense' do
      AnalyzeExpenseDataService.new(
        ide_register: "141405",
        deputy_expense_list: @expense_data["141405"], 
        create_deputy_service: CreateDeputyService.new, 
        add_expense_service: AddExpenseService.new
      ).call
      expect(Deputy.find_by(ide_register: "141405")).to be_kind_of(Deputy)
      legislature = Legislature.find_by(legislature_code: "56")
      expect(legislature.all_deputy_expense_of_year(year: "2021").first.net_value).to eq(3500)
    end

    it 'Should create new legislature and add expense' do
      AnalyzeExpenseDataService.new(
        ide_register: "141405",
        deputy_expense_list: @expense_data["141405"], 
        create_deputy_service: CreateDeputyService.new, 
        add_expense_service: AddExpenseService.new
      ).call
      @expense_data["141405"].first["codLegislatura"] = "57"
      @expense_data["141405"].first["txtNumero"] = "20507"
      @expense_data["141405"].first["urlDocumento"] = "https://www.camara.leg.br/cota-parlamentar/documentos/publ/1798/2021/7206972.pdf"
      expect{
        AnalyzeExpenseDataService.new(
          ide_register: "141405",
        deputy_expense_list: @expense_data["141405"], 
          create_deputy_service: CreateDeputyService.new, 
          add_expense_service: AddExpenseService.new
        ).call
      }.to change { FinancialManagement::DeputyExpense.count }.by(1).and change { Legislature.count }.by(1).and change { Deputy.count }.by(0)
    end

    it 'Should add expense with not specified document type' do
      @expense_data["141405"].first["indTipoDocumento"] = "4"
      AnalyzeExpenseDataService.new(
        ide_register: "141405",
        deputy_expense_list: @expense_data["141405"], 
        create_deputy_service: CreateDeputyService.new, 
        add_expense_service: AddExpenseService.new
      ).call
      deputy_expense = FinancialManagement::DeputyExpense.first
      expect(deputy_expense.not_specified?).to be_truthy
    end
  end
end
