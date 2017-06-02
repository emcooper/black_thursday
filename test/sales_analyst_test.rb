require_relative "test_helper"
require_relative "../lib/sales_analyst.rb"

class SalesAnalystTest < Minitest::Test

  def test_it_initializes_with_instance_of_sales_engine
    sa = SalesAnalyst.new(@se)

    assert_instance_of SalesEngine, sa.se
  end



end
