require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_initializes_with_empty_array_and_instance_of_se
    customer = CustomerRepository.new(SalesEngine.new)

    assert_equal                [], customer.all
    assert_instance_of SalesEngine, customer.se
  end

  def test_it_initializes_with_list_of_customers
    customer = CustomerRepository.new(SalesEngine.new)
    customer.from_csv("./data/customers.csv")

    assert_instance_of Customer, customer.all.sample
  end

  def test_find_by_id_returns_nil_or_instance_of_customer
    customer = CustomerRepository.new(SalesEngine.new)
    customer.from_csv("./data/customers.csv")

    assert_equal "Joey", customer.find_by_id(1).first_name
    assert_nil           customer.find_by_id(00)
  end

  def test_find_all_by_first_name_returns_empty_array_or_matching_customers
    customer = CustomerRepository.new(SalesEngine.new)
    customer.from_csv("./data/customers.csv")

    assert_equal             [],  customer.find_all_by_first_name("aaa")
    assert_equal              12, customer.find_all_by_first_name("anne").count
    assert_equal         "Braun", customer.find_all_by_first_name("Anne")[0].last_name
    assert_instance_of Customer,  customer.find_all_by_first_name("jo").sample
  end

  def test_find_all_by_last_name_returns_empty_array_or_matching_customers
    customer = CustomerRepository.new(SalesEngine.new)
    customer.from_csv("./data/customers.csv")

    assert_equal               [],  customer.find_all_by_last_name("aaa")
    assert_equal                3, customer.find_all_by_last_name("ricka").count
    assert_equal         "Leanne", customer.find_all_by_last_name("Braun")[0].first_name
    assert_instance_of   Customer,  customer.find_all_by_last_name("ricka").sample
  end
end
