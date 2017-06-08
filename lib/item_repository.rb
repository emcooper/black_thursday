require_relative "repository"
require "bigdecimal/util"
require_relative "item"
require "bigdecimal"
require "csv"

class ItemRepository
  include Repository
  attr_reader :all, :se

  def initialize(se)
    @all   = []
    @se    = se
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id_number)
    @all.find {|item| item.id == id_number}
  end

  def find_by_name(name)
    @all.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(keyword)
    matches = []
    matches << @all.find_all do |item|
      item.description.downcase.include?(keyword.downcase)
    end
    return matches.flatten.compact
  end

  def find_all_by_price(price)
    matches = []
    matches << @all.find_all do |item|
      item.unit_price == price
    end
    return matches.flatten.compact
  end

  def find_all_by_price_in_range(range)
    matches = []
    matches << @all.find_all do |item|
      range.include?(item.unit_price)
    end
    return matches.flatten.compact
  end

  def find_all_by_merchant_id(merchant_id)
    matches = []
    matches << @all.find_all do |item|
      item.merchant_id == merchant_id
    end
    return matches.flatten.compact
  end
end
