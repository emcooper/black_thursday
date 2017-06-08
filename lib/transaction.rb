require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
  :credit_card_expiration_date, :result, :created_at,
  :updated_at, :repo

  def initialize(attributes, repo)
    @id                          = attributes[:id].to_i
    @invoice_id                  = attributes[:invoice_id].to_i
    @credit_card_number          = attributes[:credit_card_number].to_i
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result                      = attributes[:result]
    @created_at                  = Time.parse(attributes[:created_at])
    @updated_at                  = Time.parse(attributes[:updated_at])
    @repo                        = repo
  end

  def invoice
    @repo.se.invoices.find_by_id(@invoice_id)
  end

end
