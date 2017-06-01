require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_initializes_items_with_empty_array
    repo = ItemRepository.new

    assert_equal [], repo.items
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

    assert_instance_of Integer, repo.items[100].id
    assert_instance_of String, repo.items[100].name
    assert_instance_of String, repo.items[100].description
    assert_instance_of BigDecimal, repo.items[100].unit_price
    assert_instance_of Integer, repo.items[100].merchant_id
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

  def test_find_all_by_price_returns_matching_items_or_empty_array
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")

    assert_equal "Kewtie Kuddlers", repo.find_all_by_price(60)[0].name
    assert_equal "Custom Hydrographic Tumblers", repo.find_all_by_price(60)[1].name
    assert_equal [], repo.find_all_by_price(1411900)

  end

  def test_find_all_by_price_in_range_returns_empty_array_or_matching_items
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")

    assert_includes 10..15, repo.find_all_by_price_in_range(10..15)[0].unit_price
    assert_includes 10..15, repo.find_all_by_price_in_range(10..15)[1].unit_price
    assert_equal [], repo.find_all_by_price_in_range(0.001..0.005)
  end

  def test_find_all_by_merchant_id_returns_empty_array_or_list_of_matching_items
    repo = ItemRepository.new
    repo.from_csv("./data/items.csv")

    assert_equal   "small shallow bowl two tone", repo.find_all_by_merchant_id(12334609)[3].name
    assert_equal   "I Love You to the Moon and Back", repo.find_all_by_merchant_id(12334112)[0].name
    assert_equal [],  repo.find_all_by_merchant_id(00000001)
  end
end
