require "csv"
require_relative "invoice"

class InvoiceRepository
  attr_reader :invoices, :se

  def initialize(se)
    @invoices = []
    @se    = se
  end
  
  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:id]           = row[:id].to_i
      attributes[:customer_id]  = row[:customer_id].to_i
      attributes[:merchant_id]  = row[:merchant_id].to_i
      attributes[:status]       = row[:status]
      attributes[:created_at]   = DateTime.parse(row[:created_at].chomp("UTC"))
      attributes[:updated_at]   = DateTime.parse(row[:updated_at].chomp("UTC"))
      @invoices << Invoice.new(attributes, self)
    end
  end
  
  
  
end 