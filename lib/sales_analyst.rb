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
  
  def average_item_price_per_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    sum = sum_of_item_prices(merchant)
    number_of_items = merchant.items.count
    average(sum, number_of_items)
  end 
  
  def average_average_price_per_merchant
    average(sum_of_merchant_average_prices, number_of_merchants)
  end 
  
  def sum_of_item_prices(merchant)
    merchant.items.reduce(0) {|sum, item| sum += item.unit_price}
  end 
  
  def average(sum, number)
    (sum.to_d/number).round(2)
  end 
  
  def sum_of_merchant_average_prices
    se.merchants.merchants.reduce(0) do |sum, merchant| 
      sum += average_item_price_per_merchant(merchant.id)
    end 
  end 
  
  def number_of_merchants
    se.merchants.merchants.count
  end 
end
