require 'csv'

class ParseCsvFileService
  def initialize(file:)
    @file = open(file)
  end

  def call
    retry_twice = false
    begin
      csv = CSV.parse(@file, headers: true)
    rescue CSV::MalformedCSVError => e
      unless retry_twice
        retry_twice = true
        treat_csv_file
        retry
      else  
        raise e
      end
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
