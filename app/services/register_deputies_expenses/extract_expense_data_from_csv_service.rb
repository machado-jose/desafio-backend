require 'csv'

class ExtractExpenseDataFromCsvService
  def initialize(file:, uf: nil)
    @file = file
    @uf = uf
  end

  def call
    csv = CSV.parse(@file, headers: true)
    csv = csv.select{ |row| row["sgUF"].upcase.eql? @uf } if @uf.upcase.present?
    response = {}
    csv.each do |row|
      response[row["ideCadastro"]] = {} if response[row["ideCadastro"]].nil?
      response[row["ideCadastro"]]["txNomeParlamentar"] = row["txNomeParlamentar"].force_encoding("UTF-8")
      response[row["ideCadastro"]]["txtDescricao"] = row["txtDescricao"].force_encoding("UTF-8")
    end
    response
  end
end
