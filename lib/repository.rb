module Repository

  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      @all << child.new(row, self)
    end
  end

  def child
    return Merchant    if self.class.name == "MerchantRepository"
    return Item        if self.class.name == "ItemRepository"
    return Invoice     if self.class.name == "InvoiceRepository"
    return InvoiceItem if self.class.name == "InvoiceItemRepository"
    return Transaction if self.class.name == "TransactionRepository"
    return Customer    if self.class.name == "CustomerRepository"
  end
end
