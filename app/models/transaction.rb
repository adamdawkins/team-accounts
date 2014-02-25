class Transaction < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  validates :date, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.00 }

  has_many :explainations, dependent: :destroy
  has_many :categories, through: :explainations

  def balance_value
    balance = Balance.find_by_date date
    if balance.present?
      number_to_currency balance.amount
    else
      ''
    end
  end

  def unexplained_amount
    (amount - explained_amount).to_f
  end

  def explained_amount
    if explainations.length > 0
      (explainations.map(&:amount).reduce :+).to_f
    else
      0.00
    end
  end

  def value
    value = amount.to_f
    if is_credit
      value
    else
      value * -1
    end
  end

  def display_value
    number_to_currency value
  end

  def explained?
    unexplained_amount == 0.00
  end

  def label
    explainations_length = explainations.length
    if explainations_length > 1
      'split transaction'
    elsif explainations_length == 1
      explainations.first.description
    else
      description
    end
  end

  def to_s
    description
  end

  def self.accessible_attributes
    [:date, :description, :amount]
  end
end
