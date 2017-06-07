require_relative "test_helper"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

class MerchantTest < Minitest::Test
  def test_it_initializes_with_instance_variables
    merchant = Merchant.new({:id => 5, :name => "Turing School", :created_at => "2016-01-11"}, "repo_placeholder")

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_instance_of Time, merchant.created_at
  end

  def test_items_returns_list_of_items_with_matching_merchant_id
    se =  SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            })
    merchant = Merchant.new({:id => 12335819, :created_at => "2016-01-11"}, MerchantRepository.new(se))

    assert_equal "Hope nr. 3", merchant.items[0].name

  end

  def test_invoices_returns_invoices
    se =  SalesEngine.from_csv({:invoices  => "test/data/it-2/invoices.csv"})
    merchant = Merchant.new({:id => 12334115, :created_at => "2016-01-11"}, MerchantRepository.new(se))

    assert_equal 4, merchant.invoices.count
    assert_instance_of Invoice, merchant.invoices[0]
  end

  def test_customers_returns_customers
    se = create_sales_engine_with_it3_fixtures
    merchant = se.merchants.all[0]

    assert_instance_of Customer, merchant.customers.sample
    assert_equal 2, merchant.customers.count
    assert_equal "Joey", merchant.customers[0].first_name
    assert_equal "Rachel", merchant.customers[1].first_name
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
