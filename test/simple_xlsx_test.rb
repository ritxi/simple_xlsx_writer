require 'test_helper'
require 'fileutils'

module SimpleXlsxTest
  class BaseTest < Test::Unit::TestCase
    def test_top_level
      FileUtils.rm_f 'test.xlsx'
      SimpleXlsx::Serializer.new('test.xlsx') do |doc|
        doc.add_sheet 'First' do |sheet|
          sheet.add_row ['Hello', 'World', 3.14, 7]
          sheet.add_row ['Another', 'Row', Date.today, Time.parse('2010-Jul-24 12:00 UTC')]
        end
      end
    end


    def test_top_level_stream
      FileUtils.rm_f 'test_stream.xlsx'
      File.open 'test_stream.xlsx', 'wb' do |stream|
        SimpleXlsx::Serializer.new(stream) do |doc|
          doc.add_sheet 'First' do |sheet|
            sheet.add_row ['Hello', 'World', 3.14]
            sheet.add_row ['Another', 'Row', Date.today]
          end
        end
      end
    end
  end
end
