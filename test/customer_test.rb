require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_it_initializes_with_instance_variables
    c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    }, "repo_placeholder")

    assert_equal          6, c.id
    assert_equal     "Joan", c.first_name
    assert_equal   "Clarke", c.last_name
    assert_instance_of Time, c.created_at
    assert_instance_of Time, c.updated_at
  end
  
  def test_customers_returns_customers
    se = create_sales_engine_with_it3_fixtures                  
    customer = se.customers.all[1]
    
    assert_instance_of Merchant, customer.merchants.sample
    assert_equal 2, customer.merchants.count
    assert_equal "Shopin1901", customer.merchants[0].name
    assert_equal "Candisart", customer.merchants[1].name
  end 
  
  def create_sales_engine_with_it3_fixtures
    se =  SalesEngine.from_csv({:invoices  => "test/data/it-3/invoices.csv",
                                :items => "test/data/it-3/items.csv",
                                :invoice_items => "test/data/it-3/invoice_items.csv",
                                :transactions => "test/data/it-3/transactions.csv",
                                :customers => "test/data/it-3/customers.csv",
                                :merchants => "test/data/it-3/merchants.csv"})
  end 

end
