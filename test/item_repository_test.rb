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
    
    assert_instance_of Item, repo.items[0]
    assert_instance_of Item, repo.items[100]
  end 
  
  def test_item_attributes_are_correctly_formatted
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_instance_of Fixnum, repo.items[100].id
    assert_instance_of String, repo.items[100].name
    assert_instance_of String, repo.items[100].description
    assert_instance_of BigDecimal, repo.items[100].unit_price
    assert_instance_of Fixnum, repo.items[100].merchant_id
    assert_instance_of DateTime, repo.items[100].created_at
    assert_instance_of DateTime, repo.items[100].updated_at
  end 
  
  def test_all_returns_array_of_all_items
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_equal repo.items, repo.all
  end 
  
  def test_find_by_id_returns_correct_item_or_nil
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_equal "Glitter scrabble frames", repo.find_by_id(263395617).name
    assert_nil repo.find_by_id(17)
  end 
  
  def test_find_by_name_returns_correct_item_or_nil
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_equal 263395617, repo.find_by_name("Glitter scrabble frames").id
    assert_nil repo.find_by_name("Glitter")
  end 
  
  def test_find_by_name_is_case_insensitive
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_equal 263395617, repo.find_by_name("Glitter scrabble frames").id
    assert_equal 263395617, repo.find_by_name("glitter scrabble frames").id
  end 
  
  def test_find_all_with_description_returns_matching_items_case_insensitive
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_equal "Vogue Paris Original Givenchy 2307", repo.find_all_with_description("vogue")[0].name
    assert_instance_of Array, repo.find_all_with_description("vogue")
  end 
  
  def test_find_all_with_description_returns_empty_array_for_no_match
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")
    
    assert_equal [], repo.find_all_with_description("sjdkvogue")
  end 
  
end 