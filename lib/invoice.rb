require 'time'
require 'pry'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repo

  def initialize(attributes, repo)
    @id           = attributes[:id].to_i
    @customer_id  = attributes[:customer_id].to_i
    @merchant_id  = attributes[:merchant_id].to_i
    @status       = attributes[:status].to_sym
    @created_at   = Time.parse(attributes[:created_at])
    @updated_at   = Time.parse(attributes[:updated_at])
    @repo         = repo
  end

  def merchant
    @repo.se.merchants.find_by_id(@merchant_id)
  end

  def items
    invoice_items = @repo.se.invoice_items.find_all_by_invoice_id(@id)
    item_ids = invoice_items.map {|ii| ii.item_id}
    repo.se.items.all.find_all {|item| item_ids.include?(item.id)}
  end

  def transactions
    @repo.se.transactions.find_all_by_invoice_id(@id)
  end

  def customer
    @repo.se.customers.find_by_id(@customer_id)
  end

  def is_paid_in_full?
    results = transactions.map {|trans| trans.result}
    results.include?("success")
  end

  def total
    invoice_items = @repo.se.invoice_items.find_all_by_invoice_id(@id)
    invoice_items.reduce(0) {|sum, item| sum += (item.quantity * item.unit_price)}
  end
end
