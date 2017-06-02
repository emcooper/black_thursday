require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            })
  end



end
