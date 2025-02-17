require './app/services/infrastructure/validator.rb'

class ExtractExpenseDataFromCsvService
  def initialize(parse_csv_file_service:, uf: nil)
    Validator.assert_empty_string uf unless uf.nil?

    @parse_csv_file_service = parse_csv_file_service
    @uf = uf
  end

  def call
    csv = @parse_csv_file_service.call
    headers = csv.headers.select{ |header| !header.eql? 'ideCadastro' }
    csv = csv.select{ |row| row["sgUF"].upcase.eql? @uf } if @uf.present?
    response = {}
    csv.each do |row|
      next if row["sgUF"].nil? or row["ideCadastro"].nil?
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
