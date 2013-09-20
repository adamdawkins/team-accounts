class Transaction < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  validates_presence_of :date
  validates_presence_of :description
  validates_presence_of :amount
  validates :amount, numericality: {greater_than: 0.00}

  has_many :explainations, dependent: :destroy
  has_many :categories, through: :explainations

  def unexplained_amount
    (amount - explained_amount).to_f
  end

  def explained_amount
    if explainations.length > 0
      (explainations.collect(&:amount).reduce :+).to_f
    else
      0.00
    end
  end

  def value
    if self.is_credit
      amount.to_f
    else 
      amount.to_f * -1
    end
  end

  def display_value
    number_to_currency value
  end

  def explained?
    unexplained_amount == 0.00
  end

  def label
    if explainations.length > 1
      'split transaction'
    elsif explainations.length == 1
      explainations.first.description
    else
      description 
    end
  end

  def to_s
    description
  end
end
