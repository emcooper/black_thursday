require_relative 'sales_engine'
require 'time'

class Customer
    attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  def initialize(attributes, repo)
    @id         = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name  = attributes[:last_name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @repo       = repo
  end
  
  def merchants
    invoices = @repo.se.invoices.find_all_by_customer_id(@id)
    merchant_ids = invoices.map {|invoice| invoice.merchant_id}
    repo.se.merchants.all.find_all {|merchant| merchant_ids.include?(merchant.id)}
  end
end
