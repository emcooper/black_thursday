require_relative 'sales_engine'
require 'date'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    total_merchant_count = all_merchants.count
    total_items_count    = items_per_merchant.reduce(:+).to_f
    average              = total_items_count / total_merchant_count
    return average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    one_sd_above_mean = average_items_per_merchant +
    average_items_per_merchant_standard_deviation
    all_merchants.find_all  do |merch|
      merch.items.count > one_sd_above_mean
    end
  end

  def items_per_merchant
    all_merchants.map {|merchant| merchant.items.count}
  end

  def average_item_price_for_merchant(merchant_id)
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

  def average_invoices_per_merchant
    average(se.invoices.all.count, number_of_merchants).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_num_per_merchant = all_merchants.map {|merch| merch.invoices.count}
    standard_deviation(invoice_num_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    two_sds_above_mean = average_invoices_per_merchant +
    average_invoices_per_merchant_standard_deviation * 2
    all_merchants.find_all  do |merch|
      merch.invoices.count > two_sds_above_mean
    end
  end

  def bottom_merchants_by_invoice_count
    two_sds_below_mean = average_invoices_per_merchant -
    average_invoices_per_merchant_standard_deviation * 2
    all_merchants.find_all  do |merch|
      merch.invoices.count < two_sds_below_mean
    end
  end

  def invoice_count_by_day
    all_invoices.reduce(Hash.new(0)) do |h, invoice|
      h[invoice.created_at.strftime("%A")] += 1 ; h
    end
  end

  def invoice_status(status)
    total = all_invoices.count
    subcount = invoice_subcount(status)
    (subcount/total * 100).round(2)
  end

  def revenue_by_merchant(merchant_id)
    paid_invoices(merchant_id).reduce(0) {|sum, invoice| sum += invoice.total}
  end

  def top_month_for_merch(merchant_id)
    monthly_rev = paid_invoice_items(merchant_id).reduce(Hash.new(0)) do |h, ii|
       h[ii.created_at.strftime("%B")] += ii.revenue; h
    end
    monthly_rev.max_by {|k, v| v}[0]
  end

  def top_revenue_earners(number = 20)
    merchants_ranked_by_revenue[0..number-1]
  end

  def merchants_ranked_by_revenue
    sorted_ascending = all_merchants.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end
    sorted_ascending.reverse
  end

  def merchants_with_pending_invoices
    unpaid_invoices = @se.invoices.all.reject {|inv| inv.is_paid_in_full?}
    merchants = unpaid_invoices.map {|inv| inv.merchant}
    merchants.uniq
  end

  def best_item_for_merchant(merchant_id)
    top_invoice_item = paid_invoice_items(merchant_id).max_by {|ii| ii.revenue}
    @se.items.find_by_id(top_invoice_item.item_id)
  end

  def most_sold_item_for_merchant(merchant_id)
    top_invoice_item = paid_invoice_items(merchant_id).max_by {|ii| ii.quantity}
    all_top_invoice_items = paid_invoice_items(merchant_id).find_all do |ii|
      ii.quantity == top_invoice_item.quantity
    end
    all_top_invoice_items.map {|ii| @se.items.find_by_id(ii.item_id)}
  end

  def paid_invoice_items(merchant_id)
    invoice_ids = paid_invoices(merchant_id).map {|inv| inv.id}
    invoice_items = invoice_items(invoice_ids)
  end

  def paid_invoices(merchant_id)
    invoices = @se.invoices.find_all_by_merchant_id(merchant_id)
    (invoices.find_all {|invoice| invoice.is_paid_in_full?}).flatten
  end

  def sum_of_item_prices(merchant)
    merchant.items.reduce(0) {|sum, item| sum += item.unit_price}
  end

  def average(sum, number)
    (sum.to_d/number).round(2)
  end

  def sum_of_merchant_average_prices
    all_merchants.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
  end

  def number_of_merchants
    all_merchants.count
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

  def top_days_by_invoice_count
    avg_per_day = average(all_invoices.count, 7)
    std_dev = standard_deviation(invoice_count_by_day.values)
    top_days = invoice_count_by_day.select {|k, v| v > avg_per_day + std_dev}
    top_days.keys
  end

  def total_revenue_by_date(date)
    invoice_ids = @se.invoices.find_all_ids_by_date_created(date)
    invoice_items = invoice_items(invoice_ids)
    invoice_items.reduce(0) {|sum, item| sum += item.revenue}
  end

  def invoice_items(invoice_ids)
    invoice_items = invoice_ids.map do |id|
      @se.invoice_items.find_all_by_invoice_id(id)
    end
    invoice_items.flatten
  end

  def merchants_with_only_one_item
    all_merchants.find_all {|merchant| merchant.items.count == 1}
  end

  def invoice_subcount(status)
    all_invoices.reduce(0.0) do |count, invoice|
      count += 1 if invoice.status.to_sym == status; count
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do
      |merchant| merchant.created_at.strftime("%B") == month
    end
  end

  def all_merchants
    @se.merchants.all
  end

  def all_invoices
    @se.invoices.all
  end

  def all_items
    se.items.all
  end
end
