class Category < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :explainations
  has_many :transactions, through: :explainations
end
