class TransactionImport
  include ActiveModel::Model

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) } if attributes
  end

  def persisted?
    false
  end

  def save
    if imported_transactions.length > 0 &&
       imported_transactions.map(&:valid?).all?

      imported_transactions.each(&:save)
      imported_balances.each(&:save)

      true
    else
      false
    end
  end

  def imported_transactions
    imported_transactions = []

    process_csv.each do |row|
      transaction = TransactionImport.build_transaction_from_csv_row row
      imported_transactions << transaction
    end

    imported_transactions
  end

  def imported_balances
    imported_balances = []

    process_csv.each do |row|
      balance = TransactionImport.build_balance_from_csv_row(row)
      imported_balances << balance if balance
    end

    imported_balances
  end

  def self.build_transaction_from_csv_row(row)
    transaction = Transaction.new(
      row.slice(*Transaction.accessible_attributes)
    )
    transaction.is_credit = row[:paid_in].present?
    transaction.amount = transaction.is_credit ? row[:paid_in] : row[:paid_out]

    transaction
  end

  def self.build_balance_from_csv_row(row)
    amount = row[:balance]
    balance = Balance.new date: row[:date], amount: amount if amount

    balance
  end

  def process_csv
    if @file
      SmarterCSV.process(@file.path, convert_values_to_numeric: true)
    else
      []
    end
  end
end
