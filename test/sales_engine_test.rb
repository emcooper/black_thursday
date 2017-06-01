require_relative "test_helper"
require_relative "../lib/sales_engine.rb"

class SalesEngineTest < Minitest::Test

  def test_has_instance_variable_for_each_repo
    se = SalesEngine.new

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    # assert_instance_of InvoiceRepository, se.invoices
    # assert_instance_of InvoiceItemRepository, se.invoice_items
    # assert_instance_of TransactionRepository, se.transactions
    # assert_instance_of CustomerRepository, se.customers
  end

  def test_from_csv_returns_sales_engine_instance

    assert_instance_of SalesEngine, SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            })
  end

  def test_from_csv_populates_repositories
    se = SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            })
    assert_instance_of Merchant, se.merchants.merchants[0]
    assert_instance_of Item, se.items.items[0]
  end
end
