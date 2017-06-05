require 'pry'
require "csv"
require_relative "invoice_item"
require "bigdecimal"
require "bigdecimal/util"
require "time"

class InvoiceItemRepository
  attr_reader :invoice_items, :se

  def initialize(se)
      @invoice_items = []
      @se            = se
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
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
      attributes[:created_at]      = Time.parse(row[:created_at].chomp("UTC"))
      attributes[:updated_at]      = Time.parse(row[:updated_at].chomp("UTC"))
      @invoice_items << InvoiceItem.new(attributes, self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    matching_item = @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
    return matching_item
  end

  def find_all_by_item_id(item_id)
    matching_items = @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
    return [] if matching_items.nil?
    return matching_items
  end

  def find_all_by_invoice_id(invoice_id)
    matching_items =  @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
    return [] if matching_items.nil?
    return matching_items
  end
end
