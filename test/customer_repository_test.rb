require_relative 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_it_has_a_sales_engine
    data = [" merchant 1"]
    sales_engine = "engine"
    repo = CustomerRepository.new(data, sales_engine)

    assert_equal "engine", repo.sales_engine
  end

  def test_it_finds_all_customers
    data = ["John", "Paul", "George", "Ringo"]
    sales_engine = "engine"
    repo = CustomerRepository.new(data, sales_engine)

    output = repo.all

    assert_equal ["John", "Paul", "George", "Ringo"], output
  end

  def test_it_has_a_random_method
    data = ["John", "Paul", "George", "Ringo"]
    sales_engine = "engine"
    repo = CustomerRepository.new(data, sales_engine)

    assert repo.respond_to?(:random)
  end

  def test_customer_repository_holds_customer_instances
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    first_customer = repo.customers[0]

    assert_equal Customer, first_customer.class
  end

  def test_it_finds_customers_by_id
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output = repo.find_by_id(1)

    assert_equal "Joey", output.first_name
  end

  def test_it_finds_customer_by_first_name
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_by_first_name("Joey")
    output_2 = repo.find_by_first_name("joey")

    assert_equal "Ondricka", output_1.last_name
    assert_equal "Ondricka", output_2.last_name
  end

  def test_it_finds_customer_by_last_name
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_by_last_name("Reynolds")
    output_2 = repo.find_by_last_name("reynolds")

    assert_equal "Ramona", output_1.first_name
    assert_equal "Ramona", output_2.first_name
  end

  def test_it_finds_customer_by_created_at
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output = repo.find_by_created_at("2012-03-27 14:54:10 UTC")

    assert_equal "Cecelia", output.first_name
  end

  def test_it_finds_customer_by_updated_at
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output = repo.find_by_updated_at("2012-03-27 14:54:10 UTC")

    assert_equal "Cecelia", output.first_name
  end

  def test_it_finds_all_customers_by_id
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_id(1)
    output_2 = repo.find_all_by_id(11)

    assert_equal "Joey", output_1[0].first_name
    assert_equal [], output_2
  end

  def test_it_finds_all_customers_by_first_name
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_first_name("Joey")
    output_2 = repo.find_all_by_first_name("Sebastian")
    output_3 = repo.find_all_by_first_name("joey")

    assert_equal 1, output_1[0].id
    assert_equal [], output_2
    assert_equal 1, output_3[0].id
  end

  def test_it_finds_all_customers_by_last_name
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_last_name("Osinski")
    output_2 = repo.find_all_by_last_name("Abondano")
    output_3 = repo.find_all_by_last_name("osinski")

    assert_equal 2, output_1[0].id
    assert_equal [], output_2
    assert_equal 2, output_3[0].id
  end

  def test_it_finds_all_customers_by_created_at
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    output_2 = repo.find_all_by_created_at("2015-03-27 14:54:09 UTC")

    assert_equal 1, output_1[0].id
    assert_equal [], output_2
  end

  def test_it_finds_all_customers_by_updated_at
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('customers_fixture.csv')
    data = CustomerParser.new(input_csv, merchant_repository).load_csv
    repo = CustomerRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    output_2 = repo.find_all_by_updated_at("2015-03-27 14:54:09 UTC")

    assert_equal 1, output_1[0].id
    assert_equal [], output_2
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end
