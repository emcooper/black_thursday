require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_initializes_items_with_empty_array
    repo = InvoiceItemRepository.new("se_placeholder")

    assert_equal [], repo.invoice_items
  end

  def test_from_csv_adds_list_of_incoice_items_to_invoice_items
    repo = InvoiceItemRepository.new("se_placeholder")
    repo.from_csv("./data/invoice_items.csv")

    assert_instance_of InvoiceItem, repo.invoice_items[0]
    assert_instance_of InvoiceItem, repo.invoice_items[100]
  end

  def test_item_attributes_are_correctly_formatted
    repo = InvoiceItemRepository.new("se_placeholder")
    repo.from_csv("./data/invoice_items.csv")

    assert_instance_of Integer, repo.invoice_items[100].id
    assert_instance_of Integer, repo.invoice_items[100].item_id
    assert_instance_of Integer, repo.invoice_items[100].invoice_id
    assert_instance_of Integer, repo.invoice_items[100].quantity
    assert_instance_of BigDecimal,repo.invoice_items[100].unit_price
    assert_instance_of DateTime, repo.invoice_items[100].created_at
    assert_instance_of DateTime, repo.invoice_items[100].updated_at
  end

end
