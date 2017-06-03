require 'pry'
require "csv"
require_relative "invoice_item"
require "bigdecimal"
require "bigdecimal/util"

class InvoiceItemRepository
  attr_reader :invoice_items, :se

  def initialize(se)
      @invoice_items = []
      @se            = se
  end

  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:id]              = row[:id].to_i
      attributes[:item_id]         = row[:item_id].to_i
      attributes[:invoice_id]      = row[:invoice_id].to_i
      attributes[:quantity]        = row[:quantity].to_i
      attributes[:unit_price]      = (row[:unit_price].to_d)/ 100
      attributes[:created_at]      = DateTime.parse(row[:created_at].chomp("UTC"))
      attributes[:updated_at]      = DateTime.parse(row[:updated_at].chomp("UTC"))
      @invoice_items << InvoiceItem.new(attributes, self)
    end
  end
end
