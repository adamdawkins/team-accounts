class Explaination < ActiveRecord::Base
  belongs_to :transaction

  validates :description, presence: true
  validates :transaction, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.00 }
  validate  :amount_value


  private

  def amount_value
    error_message =  "value cannot be greater than remaining unexplained amount on transaction"
    if transaction_id #this should never be nil in reality, but keeps test simpler
      transaction = Transaction.find(transaction_id)
      errors.add(:base, error_message) if amount > transaction.unexplained_amount
    end

  end
 
end
