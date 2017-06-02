require_relative 'sales_engine'
require'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    total_merchant_count = se.merchants.merchants.count
    total_items_count    = items_per_merchant.reduce(:+).to_f
    average              = total_items_count / total_merchant_count
    return average.round(2)
  end

  def items_per_merchant
    se.merchants.merchants.map {|merchant| merchant.items.count}
  end

end
