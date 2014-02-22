class Expense < ActiveRecord::Base
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :date, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.00 }

  belongs_to :user
  belongs_to :category
end
