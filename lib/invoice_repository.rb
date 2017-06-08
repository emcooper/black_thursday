require_relative "repository"
require_relative "invoice"
require "csv"

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
    matching_invoices = []
    matching_invoices << @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
    return matching_invoices.flatten.compact
  end

  def find_all_by_merchant_id(merchant_id)
    matching_invoices = []
    matching_invoices << @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
    return matching_invoices.flatten.compact
  end

  def find_all_ids_by_date_created(date)
    matching_invoices = []
    matching_invoices << @all.find_all do |invoice|
      invoice.created_at == date
    end
    matching_invoices.flatten.compact.map {|invoice| invoice.id}
  end

  def find_all_by_status(status)
    matching_invoices = []
    matching_invoices << @all.find_all do |invoice|
      invoice.status == status
    end
    return matching_invoices.flatten.compact
  end
end
