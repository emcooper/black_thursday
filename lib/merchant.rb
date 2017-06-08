class Merchant
  attr_reader :id, :name, :repo, :created_at

  def initialize(attributes, repo)
    @id          = attributes[:id].to_i
    @name        = attributes[:name]
    @created_at  = Time.parse(attributes[:created_at])
    @repo        = repo
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
    repo.se.customers.all.find_all {|cust| customer_ids.include?(cust.id)}
  end
end
