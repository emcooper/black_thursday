require_relative 'test_helper'
require_relative '../lib/transaction'


class TransactionTest < Minitest::Test

  def test_it_initializes_with_instance_variables
    t = Transaction.new({
       :id => 6,
       :invoice_id => 8,
       :credit_card_number => "4242424242424242",
       :credit_card_expiration_date => "0220",
       :result => "success",
       :created_at => Time.now,
       :updated_at => Time.now
     }, "repo_placeholder")

     assert_equal 6, t.id
     assert_equal 8, t.invoice_id
     assert_equal "4242424242424242", t.credit_card_number
     assert_equal "0220", t.credit_card_expiration_date
     assert_equal "success", t.result
     assert_instance_of Time, t.created_at
     assert_instance_of Time, t.updated_at
  end

  def test_transaction_can_find_invoice_by_invoice_id
    se =  SalesEngine.from_csv({:transactions  => "./data/transactions.csv",
                                 :invoices => "./data/invoices.csv",})

    transaction = se.transactions.transactions[0]

    assert_instance_of Invoice, transaction.invoices
    assert_equal "pending", transactions.invoices.find_by_id(1)[0].status
    assert_nil    t.invoices.find_by_id(000)
  end

end
