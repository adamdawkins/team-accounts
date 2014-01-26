class Balance < ActiveRecord::Base
  validates :date, presence: true, uniqueness: true
  validates :amount, presence: true
end
