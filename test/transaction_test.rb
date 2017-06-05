require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'


class TransactionTest < Minitest::Test

  def test_it_initializes_with_instance_variables
    t = Transaction.new({
       :id => "6",
       :invoice_id => "8",
       :credit_card_number => "4242424242424242",
       :credit_card_expiration_date => "0220",
       :result => "success",
       :created_at => "2012-02-26 20:56:57 UTC",
       :updated_at => "2015-02-26 20:56:57 UTC"
     }, "repo_placeholder")

     assert_equal 6, t.id
     assert_equal 8, t.invoice_id
     assert_equal 4242424242424242, t.credit_card_number
     assert_equal "0220", t.credit_card_expiration_date
     assert_equal "success", t.result
     assert_instance_of Time, t.created_at
     assert_instance_of Time, t.updated_at
  end

  def test_transaction_can_find_invoice_by_invoice_id
    se =  SalesEngine.from_csv({:transactions  => "./data/transactions.csv",
                                 :invoices => "./data/invoices.csv",})

    transaction = se.transactions.all[0]

    assert_instance_of Invoice, transaction.invoice
    assert_equal 12334633, transaction.invoice.merchant_id
  end

end
