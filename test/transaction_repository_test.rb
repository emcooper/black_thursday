require_relative "test_helper"
require_relative "../lib/transaction_repository"


class TransactionRepositoryTest < Minitest::Test

  def test_it_initializes_transactions_with_empty_array
    tr = TransactionRepository.new(SalesEngine.new)

    assert_equal [], tr.all
  end

  def test_it_initializes_with_array_of_transactions
    tr = TransactionRepository.new(SalesEngine.new)
    tr.from_csv("./data/transactions.csv")

    assert_instance_of Array, tr.all
    assert_instance_of Transaction, tr.all.first
  end

  def test_all_returns_array_with_transaction_objects
    tr = TransactionRepository.new(SalesEngine.new)
    tr.from_csv("./data/transactions.csv")

    assert_instance_of Array, tr.all
    assert_instance_of Transaction, tr.all[2]
  end

  def test_find_by_id_returns_nil_or_instance_of_transaction
    tr = TransactionRepository.new(SalesEngine.new)
    tr.from_csv("./data/transactions.csv")

    assert_instance_of Transaction, tr.find_by_id(1)
    assert_nil tr.find_by_id(000)
  end

  def test_find_all_by_invoice_id_returns_empty_array_or_matching_transactions
    tr = TransactionRepository.new(SalesEngine.new)
    tr.from_csv("./data/transactions.csv")

    assert_equal      2,   tr.find_all_by_invoice_id(2179).count
    assert_equal     767,  tr.find_all_by_invoice_id(2179)[1].id
    assert_equal      [], tr.find_all_by_invoice_id(0000)
  end

  def test_find_all_by_credit_card_number_returns_empty_array_or_matching_transactions
    tr = TransactionRepository.new(SalesEngine.new)
    tr.from_csv("./data/transactions.csv")

    assert_equal [],   tr.find_all_by_credit_card_number(40686319432314730)
    assert_equal 2179, tr.find_all_by_credit_card_number(4068631943231473)[0].invoice_id
    assert_equal 1,    tr.find_all_by_credit_card_number(4068631943231473).count
  end

  def test_find_all_by_result_returns_empty_array_or_matching_transactions
    tr = TransactionRepository.new(SalesEngine.new)
    tr.from_csv("./data/transactions.csv")

    assert_equal [], tr.find_all_by_result("wrong")
    assert_equal 827, tr.find_all_by_result("failed").count
  end


end
