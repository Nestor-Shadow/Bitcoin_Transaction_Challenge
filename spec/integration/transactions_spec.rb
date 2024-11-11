# spec/requests/transactions_spec.rb
require 'swagger_helper'

RSpec.describe 'Transactions API', type: :request do
  let!(:user) { create(:user) }

  path '/api/v1/transactions' do
    post 'Creates a transaction' do
      tags 'Transactions'
      consumes 'application/json'
      parameter name: :transaction, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          currency_sent: { type: :string, example: 'USD' },
          currency_received: { type: :string, example: 'BTC' },
          amount_sent: { type: :number, example: 100.0 }
        },
        required: %w[user_id currency_sent currency_received amount_sent]
      }

      response '201', 'transaction created' do
        let(:transaction) { { user_id: user.id, currency_sent: 'USD', currency_received: 'BTC', amount_sent: 100.0 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:transaction) { { user_id: user.id, currency_sent: 'USD', currency_received: 'BTC', amount_sent: 0.0 } }
        run_test!
      end
    end
  end
end
