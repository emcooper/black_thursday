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
  
  def golden_items
    sum_of_all_prices = all_item_prices.reduce(:+)
    mean = average(sum_of_all_prices, all_items.count)
    std_dev = standard_deviation(all_item_prices)
    all_items.find_all {|item| item.unit_price > (std_dev * 2 + mean)}
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
  
  def all_items 
    se.items.items
  end 
  
  def all_item_prices
    all_items.map {|item| item.unit_price}
  end 
  
  def standard_deviation(numbers)
    mean = average(numbers.reduce(:+), numbers.count)
    mean_dif_squared = numbers.map {|num| (num - mean) ** 2}
    sum_of_squares = mean_dif_squared.reduce(:+)
    Math.sqrt(sum_of_squares/(numbers.count - 1))
  end 
  
  def average_invoices_per_merchant
    average(se.invoices.invoices.count, number_of_merchants)
  end 
  
  
  
end


