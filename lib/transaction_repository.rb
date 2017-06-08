require_relative "sales_engine"
require_relative "transaction"
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
    match = @all.find {|transaction| transaction.id == id}
    return match
  end

  def find_all_by_invoice_id(invoice_id)
    matches = []
    matches << @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    return matches.flatten.compact
  end

  def find_all_by_credit_card_number(card_number)
    matches = []
    matches << @all.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
    return matches.flatten.compact
  end

  def find_all_by_result(result)
    matches = []
    matches << @all.find_all do |transaction|
      transaction.result == result
    end
    return  matches.flatten.compact
  end

end
