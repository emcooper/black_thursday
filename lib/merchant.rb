class Merchant
  attr_reader :id, :name, :repo

  def initialize(attributes, repo)
    @id   = attributes[:id].to_i
    @name = attributes[:name]
    @repo = repo
  end

  def items
    @repo.se.items.find_all_by_merchant_id(@id)
  end
  
  def invoices 
    @repo.se.invoices.find_all_by_merchant_id(@id)
  end 
  
  def customers
    invoices = @repo.se.invoices.find_all_by_merchant_id(@id)
    customer_ids = invoices.map {|invoice| invoice.customer_id}
    repo.se.customers.all.find_all {|customer| customer_ids.include?(customer.id)}
  end
end
