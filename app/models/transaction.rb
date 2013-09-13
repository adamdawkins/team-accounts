class Transaction < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :description
  validates_presence_of :amount
  validates_numericality_of :amount

  has_many :explainations, dependent: :destroy

  def unexplained_amount
    if explainations.length > 0
      ( amount - (explainations.collect(&:amount).reduce :+ )).to_f
    else
      amount.to_f
    end

  end
end
