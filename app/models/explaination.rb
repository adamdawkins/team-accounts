class Explaination < ActiveRecord::Base
  belongs_to :transaction

  validates_presence_of :description
  validates_presence_of :amount
  validates_numericality_of :amount
end
