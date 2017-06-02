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

  def test_average_items_per_merchant_returns_corrent_value_and_format
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
  
  def test_items_per_merchant_returns_array_with_number_of_items
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))

    assert_instance_of Array, sa.items_per_merchant
    assert_equal 3, sa.items_per_merchant[0]
  end
  
  def test_average_item_price_per_merchant_returns_big_decimal_average
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
    
    assert_equal  42.5, sa.average_item_price_per_merchant(12334360)
    assert_equal  16.66, sa.average_item_price_per_merchant(12334105)
    assert_instance_of BigDecimal, sa.average_item_price_per_merchant(12334105)
  end 
  
  def test_sum_of_item_prices_returns_sum
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
    merchant = sa.se.merchants.find_by_id(12334360)
    
    assert_equal  85, sa.sum_of_item_prices(merchant)
  end 
  
  def test_average_returns_rounded_big_decimal_average
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
    
    assert_equal  5, sa.average(15, 3)
    assert_equal  14.29, sa.average(100, 7)
    assert_instance_of BigDecimal, sa.average(100, 7)
  end 
  
  def test_average_average_price_per_merchant_returns_bigdecimal_average
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
                            
    assert_equal  350.29, sa.average_average_price_per_merchant                        
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end 
  
  def test_sum_of_merchant_average_prices_returns_sum
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
                            
    assert_equal 166390.01, sa.sum_of_merchant_average_prices 
  end 
  
  def test_number_of_merchants_returns_merchant_count
    sa = SalesAnalyst.new(SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            }))
                            
    assert_equal 475, sa.number_of_merchants 
  end 
end
