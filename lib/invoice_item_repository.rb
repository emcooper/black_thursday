require_relative "invoice_item"
require_relative "repository"
require "bigdecimal/util"
require "bigdecimal"
require "time"
require "csv"


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
    @all.find {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_item_id(item_id)
    matches = []
    matches << @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
    return matches.flatten.compact
  end

  def find_all_by_invoice_id(invoice_id)
    matches = []
    matches << @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
    return matches.flatten.compact
  end
end
