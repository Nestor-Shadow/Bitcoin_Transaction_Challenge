require 'swagger_helper'

RSpec.describe 'Bitcoin Price API', type: :request do
  path '/api/v1/bitcoin_price' do

    get 'Fetch Bitcoin Price in USD' do
      tags 'Bitcoin Price'
      produces 'application/json'
      response '200', 'returns Bitcoin price in USD' do
        schema type: :object,
               properties: {
                 bitcoin_usd_value: { type: :string, example: '50,000.00 USD' }
               },
               required: ['bitcoin_usd_value']

        run_test!
      end

      response '422', 'error fetching Bitcoin price' do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'No se pudo obtener el precio de Bitcoin' }
               },
               required: ['error']

        before do
          allow_any_instance_of(BitcoinPriceService).to receive(:fetch_data).and_return(nil)
        end

        run_test!
      end
    end
  end
end
