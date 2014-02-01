class Transaction < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  validates :date, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.00 }

  has_many :explainations, dependent: :destroy
  has_many :categories, through: :explainations

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
    if is_credit
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

  def self.accessible_attributes
    [:date, :description, :amount]
  end

  def self.import(file)
    # method has too many lines (to be replaced)
    CSV.foreach(file.path, headers: true) do |row|
      hash = row.to_hash
      @transaction = Transaction.new
      @transaction.date = hash['Date']
      @transaction.description = hash['Description']

      if hash['Paid in'].nil?
        @transaction.is_credit = false
        @transaction.amount = hash['Paid out'].to_f
      else
        @transaction.is_credit = true
        @transaction.amount = hash['Paid in'].to_f
      end

      @transaction.save
    end
  end
end
