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
  
end 
