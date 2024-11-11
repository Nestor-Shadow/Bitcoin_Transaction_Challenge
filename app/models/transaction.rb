# app/models/transaction.rb
class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount_sent, numericality: { greater_than: 0,  message: 'Amount sent must be greater than 0' }
  validates :amount_received, numericality: { greater_than: 0,  message: 'Amount received must be greater than 0' }
  validates :currency_sent, :currency_received, presence: true
end
