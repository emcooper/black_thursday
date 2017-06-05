require 'pry'
require "csv"
require_relative "invoice_item"
require "bigdecimal"
require "bigdecimal/util"
require "time"
require_relative "repository"

class InvoiceItemRepository
  include Repository
  attr_reader :all, :se

  def initialize(se)
      @all = []
      @se  = se
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_by_id(id)
    matching_item = @all.find do |invoice_item|
      invoice_item.id == id
    end
    return matching_item
  end

  def find_all_by_item_id(item_id)
    matching_items = @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
    return [] if matching_items.nil?
    return matching_items
  end

  def find_all_by_invoice_id(invoice_id)
    matching_items =  @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
    return [] if matching_items.nil?
    return matching_items
  end
end
