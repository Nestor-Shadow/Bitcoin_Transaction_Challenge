# app/models/user.rb
class User < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
