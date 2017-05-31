require "csv"
require "./lib/item"

class ItemRepository
  attr_reader :items 
  
  def initialize
    @items = []
  end 
  
  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:name]         = row[:name]
      attributes[:description]  = row[:description]
      attributes[:unit_price]   = row[:unit_price]
      attributes[:created_at]   = row[:created_at]
      attributes[:updated_at]   = row[:updated_at]
      @items << Item.new(attributes)
    end 
  end 
end 