require "bigdecimal"

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :repo

  def initialize(attributes, repo)
    @id          = attributes[:id]
    @name        = attributes[:name]
    @description = attributes[:description]
    @unit_price  = attributes[:unit_price]
    @merchant_id = attributes[:merchant_id]
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
    @repo        = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    @repo.se.merchants.find_by_id(@merchant_id)
  end
end
