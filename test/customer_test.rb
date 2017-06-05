require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_it_initializes_with_instance_variables
    c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    }, "repo_placeholder")

    assert_equal          6, c.id
    assert_equal     "Joan", c.first_name
    assert_equal   "Clarke", c.last_name
    assert_instance_of Time, c.created_at
    assert_instance_of Time, c.updated_at
  end

end
