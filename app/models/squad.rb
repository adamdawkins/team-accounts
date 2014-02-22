class Squad < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :explainations
end
