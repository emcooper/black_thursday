require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices, :transactions, :invoice_items,
              :customers

  def initialize
    @merchants     = MerchantRepository.new(self)
    @items         = ItemRepository.new(self)
    @invoices      = InvoiceRepository.new(self)
    @transactions  = TransactionRepository.new(self)
    @invoice_items = InvoiceItemRepository.new(self)
    @customers     = CustomerRepository.new(self)
  end

  def self.from_csv(csv)
    se = SalesEngine.new
    se.merchants.from_csv(csv[:merchants]) if csv[:merchants]
    se.items.from_csv(csv[:items]) if csv[:items]
    se.invoices.from_csv(csv[:invoices]) if csv[:invoices]
    se.transactions.from_csv(csv[:transactions]) if csv[:transactions]
    se.invoice_items.from_csv(csv[:invoice_items]) if csv[:invoice_items]
    se.customers.from_csv(csv[:customers]) if csv[:customers]
    return se
  end
end
