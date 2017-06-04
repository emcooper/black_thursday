require_relative 'sales_engine'
require'pry'


class InvoiceItem
    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :repo

  def initialize(attributes, repo)
    @id         =   attributes[:id]
    @item_id    =   attributes[:item_id]
    @invoice_id =   attributes[:invoice_id]
    @quantity   =   attributes[:quantity]
    @unit_price =   attributes[:unit_price]
    @created_at =   attributes[:created_at]
    @updated_at =   attributes[:updated_at]
    @repo       =   repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
