#require "CSV"
require_relative "transaction"
require_relative "sales_engine"


class TransactionRepository
  attr_reader :transactions, :se

  def initialize(se)
    @transactions = []
    @se           = se

  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def from_csv(csv_file_location)
    contents = CSV.open csv_file_location, headers: true, header_converters: :symbol
    contents.each do |row|
    attributes = {}
    attributes[:id]                          = row[:id].to_i
    attributes[:invoice_id]                  = row[:invoice_id].to_i
    attributes[:credit_card_number]          = row[:credit_card_number]
    attributes[:credit_card_expiration_date] = row[:credit_card_expiration_date]
    attributes[:result]                      = row[:result]
    attributes[:created_at]                  = DateTime.parse(row[:created_at].chomp("UTC"))
    attributes[:updated_at]                  = DateTime.parse(row[:updated_at].chomp("UTC"))
    @transactions << Transaction.new(attributes, self)
    end
  end

  def all
    @transactions
  end

#   all - returns an array of all known Transaction instances
# find_by_id - returns either nil or an instance of Transaction with a matching ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status


end
