require_relative 'sales_engine'

class InvoiceItem
    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at,
    :updated_at, :repo

  def initialize(attributes, repo)
    @id         =   attributes[:id].to_i
    @item_id    =   attributes[:item_id].to_i
    @invoice_id =   attributes[:invoice_id].to_i
    @quantity   =   attributes[:quantity].to_i
    @unit_price =   (attributes[:unit_price].to_d)/ 100
    @created_at =   Time.parse(attributes[:created_at])
    @updated_at =   Time.parse(attributes[:updated_at])
    @repo       =   repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def revenue
    @quantity * @unit_price
  end

  def item
      @repo.se.items.find_by_id(@item_id)
  end

  def invoice
    @repo.se.invoice.find_by_id(@invoice_id)
  end
end
