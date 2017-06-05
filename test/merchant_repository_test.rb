require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_initializes_merchants_with_empty_array
    repo = MerchantRepository.new("se_placeholder")

    assert_equal [], repo.all
    assert_instance_of MerchantRepository, repo
  end

  def test_from_csv_adds_list_of_merchants_to_merchants
    repo = MerchantRepository.new("se_placeholder")
    repo.from_csv("./data/merchants.csv")

    assert_instance_of Merchant, repo.all[0]
    assert_instance_of Merchant, repo.all[100]
  end

  def test_merchant_attributes_are_correctly_formatted
    repo = MerchantRepository.new("se_placeholder")
    repo.from_csv("./data/merchants.csv")

    assert_instance_of Integer, repo.all[100].id
    assert_instance_of String, repo.all[100].name

  end

  def test_find_by_id_returns_correct_merchant_or_nil
    repo = MerchantRepository.new("se_placeholder")
    repo.from_csv("./data/merchants.csv")

    assert_equal "SassyStrangeArt", repo.find_by_id(12334159).name
    assert_nil repo.find_by_id(17)
  end

  def test_find_by_name_returns_correct_merchant_or_nil
    repo = MerchantRepository.new("se_placeholder")
    repo.from_csv("./data/merchants.csv")

    assert_equal 12334174, repo.find_by_name("Uniford").id
    assert_nil repo.find_by_name("Glitter")
  end

  def test_find_by_name_is_case_insensitive
    repo = MerchantRepository.new("se_placeholder")
    repo.from_csv("./data/merchants.csv")

    assert_equal 12334193, repo.find_by_name("TheHamAndRat").id
    assert_equal 12334193, repo.find_by_name("thehamandrat").id
  end

  def test_find_all_by_name_returns_empty_array_or_matching_merchants_list
    repo = MerchantRepository.new("se_placeholer")
    repo.from_csv("./data/merchants.csv")

    assert_equal "TheHamAndRat", repo.find_all_by_name("ham")[0].name
    assert_equal "DeschampsDesign", repo.find_all_by_name("ham")[1].name
    assert_equal [],  repo.find_all_by_name("hamii")
  end

end
