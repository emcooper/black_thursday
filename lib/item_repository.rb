require 'pry'
require "csv"
require_relative "item"
require "bigdecimal"
require "bigdecimal/util"

class ItemRepository
  attr_reader :items, :se

  def initialize(se)
    @items = []
    @se    = se
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:id]           = row[:id].to_i
      attributes[:name]         = row[:name]
      attributes[:description]  = row[:description]
      attributes[:unit_price]   = (row[:unit_price].to_d)/ 100
      attributes[:merchant_id]  = row[:merchant_id].to_i
      attributes[:created_at]   = Time.parse(row[:created_at])
      attributes[:updated_at]   = Time.parse(row[:updated_at])
      @items << Item.new(attributes, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id_number)
    matching_item = @items.find do |item|
      item.id == id_number
    end
    return matching_item
  end

  def find_by_name(name)
    matching_item = @items.find do |item|
      item.name.downcase == name.downcase
    end
    return matching_item
  end

  def find_all_with_description(keyword)
    matching_items = @items.find_all do |item|
      item.description.downcase.include?(keyword.downcase)
    end
    return [] if matching_items.nil?
    return matching_items
  end

  def find_all_by_price(price)
    matching_price = @items.find_all do |item|
      item.unit_price == price
    end
    return [] if matching_price.nil?
    return matching_price
  end

  def find_all_by_price_in_range(range)
    all_items_within_range = @items.find_all do |item|
      range.include?(item.unit_price)
    end
    return [] if all_items_within_range.nil?
    return all_items_within_range
  end

  def find_all_by_merchant_id(merchant_id)
    matching_merchant_items = @items.find_all do |item|
      item.merchant_id == merchant_id
    end
    return [] if matching_merchant_items.nil?
    return matching_merchant_items
  end
end
