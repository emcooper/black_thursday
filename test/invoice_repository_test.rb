require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'


class InvoiceRepositoryTest < Minitest::Test
  def test_it_initializes_invoices_with_empty_invoices_array_and_sales_engine
    repo = InvoiceRepository.new(SalesEngine.new)

    assert_equal [], repo.all
    assert_instance_of SalesEngine, repo.se
  end
  
  def test_from_csv_adds_list_of_invoices_to_invoices
    repo = InvoiceRepository.new(SalesEngine.new)
    repo.from_csv("test/data/it-2/invoices.csv")

    assert_instance_of Invoice, repo.all.sample
    assert_equal 58, repo.all.count
    assert_equal 5, repo.all[4].id
    assert_equal :pending, repo.all[4].status
  end
  
  def test_find_by_id_returns_correct_invoice
    repo = InvoiceRepository.new(SalesEngine.new)
    repo.from_csv("test/data/it-2/invoices.csv")
    
    assert_equal 3, repo.find_by_id(14).customer_id
    assert_equal 12334113, repo.find_by_id(14).merchant_id
    assert_equal :pending, repo.find_by_id(14).status
  end 
  
  def test_find_all_by_customer_id_returns_empty_array_or_invoices
    repo = InvoiceRepository.new(SalesEngine.new)
    repo.from_csv("test/data/it-2/invoices.csv")
    
    assert_instance_of Invoice, repo.find_all_by_customer_id(2)[0]
    assert_equal 4, repo.find_all_by_customer_id(2).count
    assert_equal 5, repo.find_all_by_customer_id(6).count
    assert_equal [], repo.find_all_by_customer_id(100)
  end 
  
  def test_find_all_by_merchant_id_returns_empty_array_or_invoices
    repo = InvoiceRepository.new(SalesEngine.new)
    repo.from_csv("test/data/it-2/invoices.csv")
    
    assert_instance_of Invoice, repo.find_all_by_merchant_id(12334105)[0]
    assert_equal 1, repo.find_all_by_merchant_id(12334105).count
    assert_equal 10, repo.find_all_by_merchant_id(12334112).count
    assert_equal [], repo.find_all_by_merchant_id(100)
  end 
  
  def test_find_all_by_status_returns_empty_array_or_invoices
    repo = InvoiceRepository.new(SalesEngine.new)
    repo.from_csv("test/data/it-2/invoices.csv")
    
    assert_instance_of Invoice, repo.find_all_by_status(:shipped)[0]
    assert_equal 33, repo.find_all_by_status(:shipped).count
    assert_equal 11, repo.find_all_by_status(:returned).count
    assert_equal 14, repo.find_all_by_status(:pending).count
    assert_equal [], repo.find_all_by_status(:invalid_status)
  end 
end 