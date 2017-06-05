require 'pry'
require "csv"
require_relative "merchant"
require_relative "repository"

class MerchantRepository
  include Repository
  attr_reader :all, :se

  def initialize(se)
    @all      = []
    @se       = se
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id_number)
    matching_merchant = @all.find do |merchant|
      merchant.id == id_number
    end
    return matching_merchant
  end

  def find_by_name(name)
    matching_merchant = @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
    return matching_merchant
  end

  def find_all_by_name(keyword)
    matching_merchants = @all.find_all do |merchant|
      merchant.name.downcase.include?(keyword.downcase)
    end
    return [] if matching_merchants.nil?
    return matching_merchants
  end

end
