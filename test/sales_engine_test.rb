require_relative "test_helper"
require_relative "../lib/sales_engine.rb"

class SalesEngineTest < Minitest::Test

  def test_has_instance_variable_for_each_repo
    se = SalesEngine.new

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of InvoiceRepository, se.invoices
    assert_instance_of InvoiceItemRepository, se.invoice_items
    assert_instance_of TransactionRepository, se.transactions
    assert_instance_of CustomerRepository, se.customers
  end

  def test_from_csv_returns_sales_engine_instance

    assert_instance_of SalesEngine, SalesEngine.from_csv({})
  end

  def test_from_csv_populates_repositories
    se = SalesEngine.from_csv({
                            :items         => "./data/items.csv",
                            :merchants     => "./data/merchants.csv",
                            :invoices      => "test/data/it-2/invoices.csv",
                            :invoice_items => "test/data/it-4/invoice_items.csv",
                            :transactions  => "test/data/it-4/transactions.csv",
                            :customers     => "test/data/it-4/customers.csv"
                            })

    assert_instance_of Merchant,se.merchants.all.sample
    assert_instance_of Item,    se.items.all.sample
    assert_instance_of Invoice, se.invoices.all.sample
    assert_instance_of InvoiceItem, se.invoice_items.all.sample
    assert_instance_of Transaction, se.transactions.all.sample
    assert_instance_of Customer, se.customers.all.sample
  end
end
