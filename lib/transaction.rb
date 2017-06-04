

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at, :repo

  def initialize(attributes, repo)
    @id                          = attributes[:id]
    @invoice_id                  = attributes[:invoice_id]
    @credit_card_number          = attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result                      = attributes[:result]
    @created_at                  = attributes[:created_at]
    @updated_at                  = attributes[:updated_at]
    @repo                        = repo
  end

  def invoices
    @repo.se.invoices.find_by_id(@id)
  end

end
