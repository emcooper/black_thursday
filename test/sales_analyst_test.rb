require_relative "test_helper"
require_relative "../lib/sales_analyst.rb"

class SalesAnalystTest < Minitest::Test

  def test_it_initializes_with_instance_of_sales_engine
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))

    assert_instance_of SalesEngine, sa.se
  end

  def test_average_items_per_merchant_returns_correct_value_and_format
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))

    assert_equal 2.88, sa.average_items_per_merchant
    assert_instance_of Float, sa.average_items_per_merchant

  end
  
  def test_items_per_merchant_returns_array_with_number_of_items
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))

    assert_instance_of Array, sa.items_per_merchant
    assert_equal 3, sa.items_per_merchant[0]
  end
  
  def test_average_item_price_for_merchant_returns_big_decimal_average
    sa = new_sales_analyst_with_items_and_merchants
    
    assert_equal  42.5, sa.average_item_price_for_merchant(12334360)
    assert_equal  16.66, sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
  end
  
  def test_average_items_per_merchant_sd_returns_correct_value

    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
    assert_instance_of Float, sa.average_items_per_merchant_standard_deviation
  end 
  
  # def test_merchants_with_high_item_count_returns_array_with_merchants
  #  sa = SalesAnalyst.new(SalesEngine.from_csv({
  #                            :items     => "./data/items.csv",
  #                            :merchants => "./data/merchants.csv",
  #                            }))
  # 
  #  assert_instance_of Array, sa.merchants_with_high_item_count
  #  assert 6.14 < sa.merchants_with_high_item_count.sample.items.count
  #  refute 6.14 > sa.merchants_with_high_item_count.sample.items.count
  # end
  # 
  def test_sum_of_item_prices_returns_sum
    sa = new_sales_analyst_with_items_and_merchants
    
    merchant = sa.se.merchants.find_by_id(12334360)
    
    assert_equal  85, sa.sum_of_item_prices(merchant)
  end 
  
  def test_average_returns_rounded_big_decimal_average
    sa = new_sales_analyst_with_items_and_merchants
    
    assert_equal  5, sa.average(15, 3)
    assert_equal  14.29, sa.average(100, 7)
    assert_instance_of BigDecimal, sa.average(100, 7)
  end 
  
  def test_average_average_price_per_merchant_returns_bigdecimal_average
    sa = new_sales_analyst_with_items_and_merchants
                            
    assert_equal  350.29, sa.average_average_price_per_merchant                        
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end 
  
  def test_sum_of_merchant_average_prices_returns_sum
    sa = new_sales_analyst_with_items_and_merchants
                            
    assert_equal 166390.01, sa.sum_of_merchant_average_prices 
  end 
  
  def test_number_of_merchants_returns_merchant_count
    sa = new_sales_analyst_with_items_and_merchants
                            
    assert_equal 475, sa.number_of_merchants 
  end 
  
  def test_golden_items_returns_items_2_standard_deviations_above_item_price
    sa = new_sales_analyst_with_items_and_merchants
                            
    assert_instance_of Item, sa.golden_items[0]
    assert_equal 5, sa.golden_items.count
  end 
  
  def test_all_items_returns_array_of_all_items
    sa = new_sales_analyst_with_items_and_merchants
    
    assert_instance_of Item, sa.all_items[0]
    assert_equal 1367, sa.all_items.count
  end 
  
  def test_all_item_prices_returns_array_of_prices
    sa = new_sales_analyst_with_items_and_merchants
    
    assert_instance_of BigDecimal, sa.all_item_prices[0]
    assert_equal 1367, sa.all_item_prices.count
  end 
  
  def test_standard_deviation_returns_standard_deviation
    sa = new_sales_analyst_with_items_and_merchants
    
    assert_equal 13.946, sa.standard_deviation([3,5,10,30,32]).round(3)
    assert_equal 40.05, sa.standard_deviation([89,5,21,5]).round(3)
  end 
  
  def test_average_invoices_per_merchant_returns_average
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal 5.27, sa.average_invoices_per_merchant
  end 
  
  def test_average_invoices_per_merchant_standard_deviation_returns_standard_deviation
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal 2.1, sa.average_invoices_per_merchant_standard_deviation
  end 
  
  def test_top_merchants_by_invoice_count_returns_merchants
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal 1, sa.top_merchants_by_invoice_count.count
    assert_equal 10, sa.top_merchants_by_invoice_count[0].invoices.count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count[0]
  end 
  
  def test_bottom_merchants_by_invoice_count_returns_merchants
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal 1, sa.bottom_merchants_by_invoice_count.count
    assert_equal 1, sa.bottom_merchants_by_invoice_count[0].invoices.count
    assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count[0]
  end 
  
  def test_top_days_by_invoice_count_returns_days
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal ["Monday", "Sunday"], sa.top_days_by_invoice_count
  end 
  
  def test_invoice_subcount_returns_number_matching_status
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal 33, sa.invoice_subcount(:shipped)
  end 
  
  def test_invoice_status_returns_percent
    sa = new_sales_analyst_with_merchants_and_invoices_fixtures
    
    assert_equal 56.9, sa.invoice_status(:shipped)
    assert_equal 18.97, sa.invoice_status(:returned)
    assert_equal 24.14, sa.invoice_status(:pending)
  end 
  
  def new_sales_analyst_with_items_and_merchants
    SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
    
  end
  
  def new_sales_analyst_with_merchants_and_invoices_fixtures
    SalesAnalyst.new(SalesEngine.from_csv({
                            :invoices  => "test/data/it-2/invoices.csv",
                            :merchants => "test/data/it-2/merchants.csv",
                            }))
    
  end
end
