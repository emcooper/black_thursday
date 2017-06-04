require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices

  def initialize
    @merchants = MerchantRepository.new(self)
    @items     = ItemRepository.new(self)
    @invoices  = InvoiceRepository.new(self)
  end

  def self.from_csv(csv_file_locations)
    se = SalesEngine.new
    se.merchants.from_csv(csv_file_locations[:merchants]) if csv_file_locations[:merchants]
    se.items.from_csv(csv_file_locations[:items]) if csv_file_locations[:items]
    se.invoices.from_csv(csv_file_locations[:invoices]) if csv_file_locations[:invoices]
    return se
  end
end
