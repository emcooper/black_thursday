require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test 
  def test_it_initializes_with_items_list
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_instance_of Item, repo.items[0]
  end 
  
  def test_from_csv_adds_list_of_items_to_items
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    contents = CSV.open "./data/items.csv"
    #expected = contents.split("\n").count
    
    assert_instance_of Item, repo.items[0]
  end 
  
end 