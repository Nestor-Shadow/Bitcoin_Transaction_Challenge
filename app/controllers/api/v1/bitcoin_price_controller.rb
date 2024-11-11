module Api
  module V1
    class BitcoinPriceController < ApplicationController
      def show
        bitcoin_data = fetch_bitcoin_data
        return render json: { bitcoin_usd_value: format_bitcoin_price(bitcoin_data) } if bitcoin_data.present?

        render json: { error: 'No se pudo obtener el precio de Bitcoin' }, status: :unprocessable_entity
      end

      private

      def fetch_bitcoin_data
        BitcoinPriceService.new.fetch_data
      end

      def format_bitcoin_price(bitcoin_value)
        "#{bitcoin_value['rate']} #{bitcoin_value['code']}"
      end
    end
  end
end
