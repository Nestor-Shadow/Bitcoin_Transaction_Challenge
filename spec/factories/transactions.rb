FactoryBot.define do
  factory :transaction do
    user
    currency_sent { 'USD' }
    currency_received { 'BTC' }
    amount_sent { 100.0 }
    amount_received { 0.00013045 }
    timestamp { Time.now }
  end
end
