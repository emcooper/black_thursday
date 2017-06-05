require_relative "transaction"
require_relative "sales_engine"
require_relative "repository"

class TransactionRepository
  include Repository
  attr_reader :all, :se

  def initialize(se)
    @all = []
    @se  = se
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def find_by_id(id)
    matching_transaction = @all.find {|transaction| transaction.id == id}
    return matching_transaction
  end

  def find_all_by_invoice_id(invoice_id)
    matching_transactions = []
    matching_transactions << @all.find_all {|transaction| transaction.invoice_id == invoice_id}
    return matching_transactions.flatten.compact
  end

  def find_all_by_credit_card_number(card_number)
    matching_transactions = []
    matching_transactions << @all.find_all {|transaction| transaction.credit_card_number == card_number}
    return matching_transactions.flatten.compact
  end

  def find_all_by_result(result)
    matching_transactions = []
    matching_transactions << @all.find_all {|transaction| transaction.result == result}
    return  matching_transactions.flatten.compact
  end

end
