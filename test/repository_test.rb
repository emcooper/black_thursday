require_relative "test_helper"
require_relative "../lib/repository"

class MerchantTest < Minitest::Test
  def test_from_csv_populates_all_with_array_of_child_objects
    repo = MerchantRepository.new("se_placeholder")
    repo.from_csv("./data/merchants.csv")

    assert_instance_of Merchant, repo.all.first
    assert "Shopin1901", repo.all.first.name
    assert_instance_of Merchant, repo.all.last
    assert "CJsDecor", repo.all.last.name
  end 
  
  def test_child_returns_correct_child_class
    merchant_repo = MerchantRepository.new("se_placeholder")
    assert_equal Merchant, merchant_repo.child
    
    item_repo = ItemRepository.new("se_placeholder")
    assert_equal Item, item_repo.child
    
    invoice_repo = InvoiceRepository.new("se_placeholder")
    assert_equal Invoice, invoice_repo.child
  end 
end 