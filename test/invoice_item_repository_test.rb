require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_initializes_items_with_empty_array
    repo = InvoiceItemRepository.new(SalesEngine.new)

    assert_equal [], repo.invoice_items
  end

  def test_from_csv_adds_list_of_incoice_items_to_invoice_items
    repo = InvoiceItemRepository.new(SalesEngine.new)
    repo.from_csv("./data/invoice_items_fixture.csv")

    assert_instance_of InvoiceItem, repo.invoice_items[0]
    assert_instance_of InvoiceItem, repo.invoice_items[100]
  end

  def test_item_attributes_are_correctly_formatted
    repo = InvoiceItemRepository.new(SalesEngine.new)
    repo.from_csv("./data/invoice_items_fixture.csv")

    assert_instance_of Integer, repo.invoice_items[100].id
    assert_instance_of Integer, repo.invoice_items[100].item_id
    assert_instance_of Integer, repo.invoice_items[100].invoice_id
    assert_instance_of Integer, repo.invoice_items[100].quantity
    assert_instance_of BigDecimal,repo.invoice_items[100].unit_price
    assert_instance_of Time, repo.invoice_items[100].created_at
    assert_instance_of Time, repo.invoice_items[100].updated_at
  end

  def test_all_returns_array_of_all_invoice_item_instances
    repo = InvoiceItemRepository.new(SalesEngine.new)
    repo.from_csv("./data/invoice_items_fixture.csv")

    assert_equal repo.invoice_items, repo.all
  end

  def test_find_by_id_returns_nil_or_matching_instance_of_invoice_id
    repo = InvoiceItemRepository.new(SalesEngine.new)
    repo.from_csv("./data/invoice_items_fixture.csv")

    assert_equal 263454779, repo.find_by_id(2).item_id
    assert_nil repo.find_by_id(1000)
  end

  def test_find_all_by_item_id_returns_empty_array_or_matching_invoice_items
    repo = InvoiceItemRepository.new(SalesEngine.new)
    repo.from_csv("./data/invoice_items_fixture.csv")

    assert_equal 1, repo.find_all_by_item_id(263519844)[0].id
    assert_equal [], repo.find_all_by_item_id(000)
  end

  def test_find_all_by_invoice_id_returns_empty_array_or_matching_invoice_items
    repo = InvoiceItemRepository.new(SalesEngine.new)
    repo.from_csv("./data/invoice_items_fixture.csv")

    assert_equal 23 , repo.find_all_by_invoice_id(5)[0].id
    assert_instance_of Array, repo.find_all_by_invoice_id(5)
    assert_equal [], repo.find_all_by_invoice_id(000)
  end

end
