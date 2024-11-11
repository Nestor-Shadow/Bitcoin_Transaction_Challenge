require 'net/http'
require 'json'

# app/services/bitcoin_price_service.rb
class BitcoinPriceService
  API_URL = 'https://api.coindesk.com/v1/bpi/currentprice.json'.freeze

  def fetch_data
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    data['bpi']['USD']
  rescue StandardError => e
    puts "Error al consumir la API: #{e.message}"
    nil
  end
end
