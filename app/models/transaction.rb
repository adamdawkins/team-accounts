class Transaction < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :description
  validates_presence_of :amount
  validates_numericality_of :amount

  has_many :explainations

  def unexplained_amount
    ( amount - (explainations.collect(&:amount).reduce :+ )).to_f
  end
end
