require_relative '../lib/customer'
require_relative "repository"

class CustomerRepository
    include Repository
    attr_reader :all, :se

  def initialize(se)
    @se = se
    @all = []
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_by_id(id)
    matching_customer = @all.find {|customer| customer.id == id}
    return matching_customer
  end

  def find_all_by_first_name(first_name)
    matching_customers = []
    matching_customers << @all.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
    return matching_customers.flatten.compact
  end

  def find_all_by_last_name(last_name)
    matching_customers = []
    matching_customers << @all.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
    return matching_customers.flatten.compact
  end

end
