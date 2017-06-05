require "csv"
require_relative "invoice"
require_relative "repository"

class InvoiceRepository
  include Repository
  attr_reader :invoices, :se

  def initialize(se)
    @invoices = []
    @se       = se
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:id]           = row[:id].to_i
      attributes[:customer_id]  = row[:customer_id].to_i
      attributes[:merchant_id]  = row[:merchant_id].to_i
      attributes[:status]       = row[:status].to_sym
      attributes[:created_at]   = Time.parse(row[:created_at])
      attributes[:updated_at]   = Time.parse(row[:updated_at])
      @invoices << Invoice.new(attributes, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id_number)
    @invoices.find {|invoice| invoice.id == id_number}
  end

  def find_all_by_customer_id(customer_id)
    matching_invoices = []
    matching_invoices << @invoices.find_all {|invoice| invoice.customer_id == customer_id}
    return matching_invoices.flatten.compact
  end

  def find_all_by_merchant_id(merchant_id)
    matching_invoices = []
    matching_invoices << @invoices.find_all {|invoice| invoice.merchant_id == merchant_id}
    return matching_invoices.flatten.compact
  end

  def find_all_by_status(status)
    matching_invoices = []
    matching_invoices << @invoices.find_all {|invoice| invoice.status == status}
    return matching_invoices.flatten.compact
  end
end
