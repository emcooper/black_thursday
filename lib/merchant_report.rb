require_relative 'sales_analyst'
require 'colorize'

class MerchantReport
  attr_reader :sa
  def initialize
    se = SalesEngine.from_csv({
                            :items         => "./data/items.csv",
                            :merchants     => "./data/merchants.csv",
                            :invoices      => "./data/invoices.csv",
                            :invoice_items => "./data/invoice_items.csv",
                            :transactions  => "./data/transactions.csv",
                            :customers     => "./data/customers.csv"
                            })

    @sa = SalesAnalyst.new(se)
  end

  def start
    puts "\nWelcome to Merchant Reporting!".magenta
    input =
    while start_message == "r"
      print "\nPlease enter a merchant_id:".magenta
      merchant_id = gets.chomp.to_i
      generate_report(merchant_id)
    end
  end

  def generate_report(merchant_id)
    merchant = @sa.se.merchants.find_by_id(merchant_id)
    item_names = merchant.items.map {|item| item.name}
    print_summary(merchant)
    print_sales_analysis(merchant)
  end

  def print_summary(merchant)
    item_names = merchant.items.map {|item| item.name}
    puts "\n\nMerchant Name: #{merchant.name}\n".blue
    puts "Items Offered:\n*#{item_names.join("\n*")}\n\n".blue
  end

  def print_sales_analysis(merchant)
    puts "Sales Analysis:".green
    puts "Total Revenue: $#{@sa.revenue_by_merchant(merchant.id).to_f}".green
    puts "Highest grossing month:#{@sa.top_month_for_merch(merchant.id)}".green
    puts "Total Number of Orders: #{merchant.invoices.count}".green
    puts "Total Number of Customers: #{merchant.customers.count}".green
    puts "Ranking by Total Revenue: #{rank(merchant)}\n\n".green
  end

  def start_message
    puts "Would you like to quit (q) or generate a report (r)?"
    return gets.chomp
  end

  def rank(merchant)
    @sa.merchants_ranked_by_revenue.rindex(merchant) + 1
  end
end
