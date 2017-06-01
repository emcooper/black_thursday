
require_relative 'merchant_repository'
require_relative 'item_repository'


class SalesEngine
  attr_reader :merchants, :items

  def initialize
    @merchants = MerchantRepository.new(self)
    @items     = ItemRepository.new(self)
  end

  def self.from_csv(csv_file_locations)
    se = SalesEngine.new
    se.merchants.from_csv(csv_file_locations[:merchants])
    se.items.from_csv(csv_file_locations[:items])
    return se
  end

end
