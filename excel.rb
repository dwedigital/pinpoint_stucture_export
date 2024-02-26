module Excel
  require 'caxlsx'
  require 'pry'

  class Client
    def initialize(file_path)
      @file_path = file_path
    end

    def create_file
      Axlsx::Package.new do |p|
        p.workbook.add_worksheet(name: 'Departments')
        p.workbook.add_worksheet(name: 'Divisions')
        p.workbook.add_worksheet(name: 'Locations')
        p.workbook.add_worksheet(name: 'Custom_Fields')

        p.serialize(@file_path)
      end
    end

    def write(data = {})
      puts data
      Axlsx::Package.new do |p|
        data.each do |sheet_name, sheet_data|
          next if sheet_data['data'].empty?

          p.workbook.add_worksheet(name: sheet_name.to_s) do |sheet|
            sheet.add_row sheet_data['data'][0].keys
            sheet_data['data'].each do |row|
              sheet.add_row row.values
            end
          end
        end
        p.serialize(@file_path)
      end
    end
  end
end
