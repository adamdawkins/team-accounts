class Explaination < ActiveRecord::Base
  belongs_to :transaction

  validates :description, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction, presence: true
 
end
