require 'test_helper'
require 'rexml/document'
require 'time'

module SimpleXlsxTest
  class SheetTest < Test::Unit::TestCase
    def test_column_index
      assert_equal 'A', SimpleXlsx::Sheet.column_index(0)
      assert_equal 'B', SimpleXlsx::Sheet.column_index(1)
      assert_equal 'C', SimpleXlsx::Sheet.column_index(2)
      assert_equal 'D', SimpleXlsx::Sheet.column_index(3)
      assert_equal 'Y', SimpleXlsx::Sheet.column_index(24)
      assert_equal 'Z', SimpleXlsx::Sheet.column_index(25)
    end

    def test_column_index_two_digits
      assert_equal 'AA', SimpleXlsx::Sheet.column_index(0 + 26)
      assert_equal 'AB', SimpleXlsx::Sheet.column_index(1 + 26)
      assert_equal 'AC', SimpleXlsx::Sheet.column_index(2 + 26)
      assert_equal 'AD', SimpleXlsx::Sheet.column_index(3 + 26)
      assert_equal 'AZ', SimpleXlsx::Sheet.column_index(25 + 26)
      assert_equal 'BA', SimpleXlsx::Sheet.column_index(25 + 26 + 1)
      assert_equal 'BB', SimpleXlsx::Sheet.column_index(25 + 26 + 2)
      assert_equal 'BC', SimpleXlsx::Sheet.column_index(25 + 26 + 3)
    end

    def test_format_field_for_strings
      v = SimpleXlsx::Sheet.format_field_and_type_and_style '<escape this>'
      assert_equal [:inlineStr, '<is><t>&lt;escape this&gt;</t></is>', 5], v
    end

    def test_format_field_for_numbers
      v = SimpleXlsx::Sheet.format_field_and_type_and_style 3
      assert_equal [:n, '<v>3</v>', 3], v
      v = SimpleXlsx::Sheet.format_field_and_type_and_style(BigDecimal('45'))
      assert_equal [:n, '<v>45.0</v>', 4], v
      v = SimpleXlsx::Sheet.format_field_and_type_and_style(9.32)
      assert_equal [:n, '<v>9.32</v>', 4], v
    end

    def test_format_field_for_date
      v = SimpleXlsx::Sheet.format_field_and_type_and_style(Date.parse('2010-Jul-24'))
      assert_equal [:n, "<v>#{38_921 + 1462}</v>", 2], v
    end

    def test_format_field_for_datetime
      v = SimpleXlsx::Sheet.format_field_and_type_and_style(Time.parse('2010-Jul-24 12:00 UTC'))
      assert_equal [:n, "<v>#{38_921.5 + 1462}</v>", 1], v
    end

    def test_format_field_for_boolean
      v = SimpleXlsx::Sheet.format_field_and_type_and_style(false)
      assert_equal [:b, '<v>0</v>', 6], v
      v = SimpleXlsx::Sheet.format_field_and_type_and_style(true)
      assert_equal [:b, '<v>1</v>', 6], v
    end

    def test_add_row
      str = ''
      io = StringIO.new(str)
      SimpleXlsx::Sheet.new(nil, 'name', io) do |sheet|
        sheet.add_row ['this is ', 'a new row']
      end
      doc = REXML::Document.new str
      assert_equal 'worksheet', doc.root.name
      sheetdata = doc.root.elements['sheetData']
      assert sheetdata
      row = sheetdata.elements['row']
      assert row
      assert_equal '1', row.attributes['r']
      assert_equal 2, row.elements.to_a.size
      assert_equal %w[r t s], row.elements.to_a[0].attributes.keys
    end
  end
end
