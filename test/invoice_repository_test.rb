require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'


class InvoiceRepositoryTest < Minitest::Test
  def test_it_initializes_invoices_with_empty_invoices_array_and_sales_engine
    repo = InvoiceRepository.new(SalesEngine.new)

    assert_equal [], repo.invoices
    assert_instance_of SalesEngine, repo.se
  end
  
  def test_from_csv_adds_list_of_invoices_to_invoices
    repo = InvoiceRepository.new(SalesEngine.new)
    repo.from_csv("test/data/it-2/invoices.csv")

    assert_instance_of Invoice, repo.invoices[0]
    assert_equal 5, repo.invoices[4].id
    assert_equal "pending", repo.invoices[4].status
  end

end 