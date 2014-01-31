class TransactionImport
  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def save
    if imported_transactions.map(&:valid?).all?
      imported_transactions.each(&:save)
      true
    end 
  end

  def imported_transactions
    csv_rows ||= process_csv
    imported_transactions = []

    csv_rows.each do |row|
      transaction = TransactionImport.build_transaction_from_csv_row row 
      imported_transactions << transaction
    end

    imported_transactions
  end

  def self.build_transaction_from_csv_row row
    transaction = Transaction.new
    puts row
    transaction.attributes = row.slice(*Transaction.accessible_attributes)
    transaction.is_credit = row[:paid_out].nil?
    transaction.amount = transaction.is_credit ? row[:paid_in] : row[:paid_out] 

    transaction
  end
  
  def process_csv
    SmarterCSV.process(@file.path, {convert_values_to_numeric: true})
  end

end
