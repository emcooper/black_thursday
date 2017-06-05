require 'pry'

module Repository

  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      @all << child.new(row, self)
    end
  end
  
  def child
    return Merchant    if self.class == MerchantRepository
    return Item        if self.class == ItemRepository
    return Invoice     if self.class == InvoiceRepository
    return InvoiceItem if self.class == InvoiceItemRepository
    return Transaction if self.class == TransactionRepository
    return Customer    if self.class == CustomerRepository
  end 
end 