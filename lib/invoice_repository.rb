require "csv"
require_relative "invoice"
require_relative "repository"
require 'pry'

class InvoiceRepository
  include Repository
  attr_reader :all, :se

  def initialize(se)
    @all      = []
    @se       = se
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def find_by_id(id_number)
    @all.find {|invoice| invoice.id == id_number}
  end

  def find_all_by_customer_id(customer_id)
    matches = []
    matches << @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
    return matches.flatten.compact
  end

  def find_all_by_merchant_id(merchant_id)
    matches = []
    matches << @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
    return matches.flatten.compact
  end

  def find_all_ids_by_date_created(date)
    matches = []
    matches << @all.find_all do |invoice|
      invoice.created_at == date
    end
    matches.flatten.compact.map {|invoice| invoice.id}
  end

  def find_all_by_status(status)
    matches = []
    matches << @all.find_all do |invoice|
      invoice.status == status
    end
    return matches.flatten.compact
  end
end
