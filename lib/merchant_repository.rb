require 'pry'
require "csv"
require_relative "merchant"


class MerchantRepository
    attr_reader :merchants

  def initialize
    @merchants = []
  end

  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:id]           = row[:id].to_i
      attributes[:name]         = row[:name]
      @merchants << Merchant.new(attributes)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id_number)
    matching_merchant = @merchants.find do |merchant|
      merchant.id == id_number
    end
    return matching_merchant
  end

  def find_by_name(name)
    matching_merchant = @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
    return matching_merchant
  end

  def find_all_by_name(keyword)
    matching_merchants = @merchants.find_all do |merchant|
      merchant.name.downcase.include?(keyword.downcase)
    end
    return [] if matching_merchants.nil?
    return matching_merchants
  end

end
