require 'csv'

class ExtractExpenseDataFromCsvService
  def initialize(file:, uf: nil)
    @file = file
    @uf = uf
  end

  def call
    csv = CSV.parse(@file, headers: true)
    headers = csv.headers.select{ |header| !header.eql? 'ideCadastro' }
    csv = csv.select{ |row| row["sgUF"].upcase.eql? @uf } if @uf.upcase.present?
    response = {}
    csv.each do |row|
      response[row["ideCadastro"]] = [] if response[row["ideCadastro"]].nil?
      data = {}
      headers.each do |header|
        data[header] = row[header].present? ? row[header].force_encoding("UTF-8") : nil
      end
      response[row["ideCadastro"]].push(data)
    end
    response
  end
end
