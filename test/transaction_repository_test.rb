require_relative "test_helper"
require_relative "../lib/transaction_repository"


class TransactionRepositoryTest < Minitest::Test

  def test_it_initializes_transactions_with_empty_array
    tr = TransactionRepository.new("se_placeholder")

    assert_equal [], tr.transactions
  end

  def test_it_initializes_with_array_of_transactions
    tr = TransactionRepository.new("se_placeholder")
    tr.from_csv("./data/transactions.csv")

    assert_instance_of Array, tr.transactions
    assert_instance_of Transaction, tr.transactions.first

  end




end
