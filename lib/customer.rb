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

  def customer_invoices
    @repo.se.invoices.find_all_by_customer_id(@id)
  end

  def merchants
    merchant_ids = customer_invoices.map do |invoice|
      invoice.merchant_id
    end
    repo.se.merchants.all.find_all do |merchant|
      merchant_ids.include?(merchant.id)
    end
  end
end
