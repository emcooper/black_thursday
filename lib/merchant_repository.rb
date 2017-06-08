require_relative "repository"
require_relative "merchant"
require "csv"

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
    @all.find {|merchant| merchant.id == id_number}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(keyword)
    matches = @all.find_all do |merchant|
      merchant.name.downcase.include?(keyword.downcase)
    end
    return matches.flatten.compact
  end
end
