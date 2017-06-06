require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def test_it_initializes_with_instance_variables
    invoice = Invoice.new({
      :id          => "20",
      :customer_id => "1",
      :merchant_id => "2",
      :status      => "pending",
      :created_at  => "2008-01-07",
      :updated_at  => "2009-01-07"},
      "repo_placeholder")

    assert_equal 20, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 2, invoice.merchant_id
    assert_equal :pending, invoice.status
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice.updated_at
    assert_equal "repo_placeholder", invoice.repo
  end
  
  def test_merchant_returns_merchant 
    se =  SalesEngine.from_csv({:invoices  => "test/data/it-2/invoices.csv",
                                :merchants => "./data/merchants.csv",})                    
    invoice = se.invoices.all[0]
    
    assert_instance_of Merchant, invoice.merchant
    assert_equal "Shopin1901", invoice.merchant.name
  end 
  
  def test_items_returns_items
    se = create_sales_engine_with_it3_fixtures                  
    invoice = se.invoices.all[0]
    
    assert_equal 3, invoice.items.count
    assert_equal "Bangle Bracelet Heart", invoice.items[0].name
    assert_equal "iridescent", invoice.items[2].name
  end 
  
  def test_transactions_returns_transactions
    se = create_sales_engine_with_it3_fixtures                  
    invoice = se.invoices.all[2]
    
    assert_equal 2, invoice.transactions.count
    assert_equal 3, invoice.transactions[0].id
    assert_equal 4, invoice.transactions[1].id
    assert_equal "failed", invoice.transactions[0].result
    assert_equal "success", invoice.transactions[1].result
  end 
  
  def create_sales_engine_with_it3_fixtures
    se =  SalesEngine.from_csv({:invoices  => "test/data/it-3/invoices.csv",
                                :items => "test/data/it-3/items.csv",
                                :invoice_items => "test/data/it-3/invoice_items.csv",
                                :transactions => "test/data/it-3/transactions.csv",
                                :customer => "test/data/it-3/customers.csv",
                                :merchants => "test/data/it-3/merchants.csv"})
  end 
  
end 
