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

end
