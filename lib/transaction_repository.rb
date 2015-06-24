class TransactionRepository
  attr_reader :transactions,
              :sales_engine

  def initialize(data, sales_engine)
    @transactions = data.map { |attributes| Transaction.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@transactions.size} rows"
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_by_invoice_id(invoice_id)
    transactions.find do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_by_result(result)
    transactions.find { |transaction| transaction.result == result }
  end

  def find_by_created_at(created_at)
    transactions.find { |transaction| transaction.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    transactions.find { |transaction| transaction.updated_at == updated_at }
  end

  def find_all_by_id(id)
    transactions.select { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.select do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_all_by_result(result)
    transactions.select { |transaction| transaction.result == result }
  end

  def find_all_by_created_at(created_at)
    transactions.select { |transaction| transaction.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    transactions.select { |transaction| transaction.updated_at == updated_at }
  end

  def find_invoice(invoice_id)
    sales_engine.find_invoice_by_transaction_id(invoice_id)
  end

  def charge(payment_data, invoice_id)
    credit_card_number = payment_data[:credit_card_number]
    credit_card_expiration_date = payment_data[:credit_card_expiration_date]
    result = payment_data[:result]
    new_transaction = Transaction.new(
        {id: next_id,
         invoice_id: invoice_id,
         credit_card_number: credit_card_number,
         credit_card_expiration_date: credit_card_expiration_date,
         result: result,
         created_at: Time.now.strftime("%c %d, %Y"),
         updated_at: Time.now.strftime("%c %d, %Y")
        },
        self
    )
    transactions << new_transaction
  end

  private

  def next_id
    if transactions.last.nil?
      1
    else
      transactions.last.id.next
    end
  end
end
