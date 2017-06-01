class Merchant
  attr_reader :id, :name, :repo

  def initialize(attributes, repo)
    @id   = attributes[:id]
    @name = attributes[:name]
    @repo = repo
  end

  def items
    @repo.se.items.find_all_by_merchant_id(@id)
  end
end
