require_relative "test_helper"
require_relative "../lib/invoice_item.rb"
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def test_invoice_item_initilizes_with_instance_variables
    ii = InvoiceItem.new({
       :id => 6,
       :item_id => 7,
       :invoice_id => 8,
       :quantity => 1,
       :unit_price => BigDecimal.new(10.99, 4),
       :created_at => Time.now,
       :updated_at => Time.now
     }, "repo_placeholder")

     assert_equal  6, ii.id
     assert_equal  7, ii.item_id
     assert_equal  8, ii.invoice_id
     assert_equal  1, ii.quantity
     assert_equal  0.1099e2, ii.unit_price
     assert_instance_of  Time, ii.created_at
     assert_instance_of  Time, ii.updated_at
  end

  def test_unit_price_to_dollars_returns_price_of_invoice_as_float
    ii = InvoiceItem.new({
      :unit_price  => BigDecimal.new(10.99,4)
      }, "repo_placeholder")

      assert_equal 10.99, ii.unit_price_to_dollars
  end

end
