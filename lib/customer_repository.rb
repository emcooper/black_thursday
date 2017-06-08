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
    @all.find {|customer| customer.id == id}
  end

  def find_all_by_first_name(first_name)
    matches = []
    matches << @all.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
    return matches.flatten.compact
  end

  def find_all_by_last_name(last_name)
    matches = []
    matches << @all.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
    return matches.flatten.compact
  end
end
