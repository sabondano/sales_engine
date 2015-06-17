require_relative 'test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_has_a_sales_engine
    data = "invoice 1"
    sales_engine = "engine"
    repo = InvoiceRepository.new(data, sales_engine)

    assert_equal "engine", repo.sales_engine
  end

  def test_it_find_all_invoices
    data = ["invoice 1", "invoice 2", "invoice 3", "invoice 4", "invoice 5"]
    sales_engine = "sales_engine"
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.all

    assert_equal 5, output.count
  end

  def test_it_has_a_random_method
    data = ["invoice 1", "invoice 2", "invoice 3", "invoice 4", "invoice 5"]
    sales_engine = "sales_engine"
    repo = InvoiceRepository.new(data, sales_engine)

    assert repo.respond_to?(:random)
  end

  def test_it_holds_invoice_instance
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    first_invoice = repo.invoices[0]

    assert_equal Invoice, first_invoice.class
  end

  def test_finds_invoice_by_id
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.find_by_invoice_id(1)

    assert_equal 26, output.merchant_id
  end

  def test_finds_by_customer_id
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.find_by_customer_id(2)

    assert_equal 27, output.merchant_id
  end

  def test_finds_by_merchant_id
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.find_by_merchant_id(86)

    assert_equal 10, output.id
  end

  def test_it_finds_by_status
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.find_by_status("shipped")

    assert_equal 1, output.id
  end

  def test_finds_by_created_at
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.find_by_created_at(DateTime.parse('2012-03-25 09:54:09 UTC'))

    assert_equal 1, output.id
  end

  def test_finds_by_updated_at
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output = repo.find_by_updated_at(DateTime.parse('2012-03-25 09:54:09 UTC'))

    assert_equal 1, output.id
  end

  def test_finds_all_invoice_by_id
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_invoice_id(2)
    output_2 = repo.find_all_by_invoice_id(11)

    assert_equal 75, output_1[0].merchant_id
    assert_equal [], output_2
  end

  def test_finds_all_by_customer_id
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_customer_id(2)
    output_2 = repo.find_all_by_customer_id(11)

    assert_equal 27, output_1[0].merchant_id
    assert_equal [], output_2
  end

  def test_finds_all_by_merchant_id
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_merchant_id(26)
    output_2 = repo.find_all_by_merchant_id(11)

    assert_equal 1, output_1[0].id
    assert_equal [], output_2
  end

  def test_it_finds_all_by_status
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_status("shipped")
    output_2 = repo.find_all_by_status("pending")

    assert_equal 10, output_1.count
    assert_equal [], output_2
  end

  def test_finds_all_by_created_at
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_created_at(DateTime.parse('2012-03-25 09:54:09 UTC'))
    output_2 = repo.find_all_by_created_at(DateTime.parse('2015-03-25 09:54:09 UTC'))

    assert_equal 1, output_1.count
    assert_equal [], output_2
  end

  def test_finds_all_by_updated_at
    sales_engine = "placeholder"
    customer_repository = "placeholder"
    input_csv = fixture_path('invoices_fixture.csv')
    data = InvoiceParser.new(input_csv, customer_repository).load_csv
    repo = InvoiceRepository.new(data, sales_engine)

    output_1 = repo.find_all_by_updated_at(DateTime.parse('2012-03-25 09:54:09 UTC'))
    output_2 = repo.find_all_by_updated_at(DateTime.parse('2015-03-25 09:54:09 UTC'))

    assert_equal 1, output_1.count
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