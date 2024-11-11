require 'swagger_helper'

RSpec.describe 'Transactions API', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { 'Content-Type': 'application/json' } }

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
        run_test! do
          expect(json['success']).to eq('Transacción completada')
        end
      end

      response '422', 'invalid request' do
        let(:transaction) { { user_id: user.id, currency_sent: 'USD', currency_received: 'BTC', amount_sent: 0.0 } }
        run_test! do
          expect(json['error']).to eq('Amount sent must be greater than 0')
        end
      end
    end
  end

  path '/api/v1/transactions/users/{user_id}' do
    get 'Fetches all transactions for a specific user' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'transactions found' do
        let(:user_id) { user.id }
        let!(:transaction) { create(:transaction, user: user) }
        run_test! do
          expect(json.length).to eq(1)
        end
      end

      response '404', 'user not found' do
        let(:user_id) { -1 }
        run_test! do
          expect(json['error']).to eq('Usuario no encontrado')
        end
      end
    end
  end

  path '/api/v1/transactions/{id}' do
    get 'Fetches a specific transaction' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'transaction found' do
        let(:transaction) { create(:transaction, user: user) }
        let(:id) { transaction.id }
        run_test! do
          expect(json['id']).to eq(transaction.id)
        end
      end

      response '404', 'transaction not found' do
        let(:id) { -1 }
        run_test! do
          expect(json['error']).to eq('Transaccion no encontrada')
        end
      end
    end
  end
end
