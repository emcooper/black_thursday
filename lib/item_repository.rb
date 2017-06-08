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
    "#<#{self.class} #{@items.size} rows>"
  end

  def find_by_id(id_number)
    matching_item = @all.find do |item|
      item.id == id_number
    end
    return matching_item
  end

  def find_by_name(name)
    matching_item = @all.find do |item|
      item.name.downcase == name.downcase
    end
    return matching_item
  end

  def find_all_with_description(keyword)
    matching_items = @all.find_all do |item|
      item.description.downcase.include?(keyword.downcase)
    end
    return [] if matching_items.nil?
    return matching_items
  end

  def find_all_by_price(price)
    matching_price = @all.find_all do |item|
      item.unit_price == price
    end
    return [] if matching_price.nil?
    return matching_price
  end

  def find_all_by_price_in_range(range)
    all_items_within_range = @all.find_all do |item|
      range.include?(item.unit_price)
    end
    return [] if all_items_within_range.nil?
    return all_items_within_range
  end

  def find_all_by_merchant_id(merchant_id)
    matching_merchant_items = @all.find_all do |item|
      item.merchant_id == merchant_id
    end
    return [] if matching_merchant_items.nil?
    return matching_merchant_items
  end
end
