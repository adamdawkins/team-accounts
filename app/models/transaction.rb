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

  def self.accessible_attributes
    [:date, :description, :amount]
  end

  def self.import(file)
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
  
  def date_from_hsbc_csv(date_string)
    months = { 
      'Jan' => 1, 'Feb' => 2, 'Mar' => 3, 'Apr' => 4, 'May' => 5, 'Jun' => 6,
      'Jul' => 7, 'Aug' => 8, 'Sep' => 9, 'Oct' => 10, 'Nov' => 11, 'Dec' => 12 
    }

    day, month, year = date_string.split(" ")
    month = months[month] 
    Date.new(year.to_i, month, day.to_i)
  end  
end
