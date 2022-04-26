require 'csv'

class ParseCsvFileService
  def initialize(file:)
    @file = open(file)
  end

  def call
    begin
      csv = CSV.parse(@file, headers: true)
    rescue CSV::MalformedCSVError => e  
      treat_csv_file
      retry
    end
    csv
  end

  private
  def treat_csv_file
    file_data = File.open(@file).read
    file_data.gsub!(/[;\"]/, {
      "\"" => '',
      ";" => ','
    })
    @file = file_data
  end
end
