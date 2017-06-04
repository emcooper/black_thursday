class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repo

  def initialize(attributes, repo)
    @id           = attributes[:id]
    @customer_id  = attributes[:customer_id]
    @merchant_id  = attributes[:merchant_id]
    @status       = attributes[:status]
    @created_at   = attributes[:created_at]
    @updated_at   = attributes[:updated_at]
    @repo         = repo
  end

  def merchant 
    @repo.se.merchants.find_by_id(@merchant_id)
  end 
  
end
