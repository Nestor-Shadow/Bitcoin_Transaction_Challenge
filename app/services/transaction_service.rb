class TransactionService
  def initialize(user, currency_sent, currency_received, amount_sent)
    @user = user
    @currency_sent = currency_sent
    @currency_received = currency_received
    @amount_sent = amount_sent
  end

  def process_transaction
    return buy_btc if buying?
    return sell_btc if selling?

    { error: 'Error en las monedas enviadas o recibidas' }
  end

  private

  def buy_btc
    return { error: 'Saldo insuficiente de USD' } if not_enough_usd_founds

    amount_received = calculate_amount_received
    transaction = create_transaction(amount_received)
    return transaction if transaction[:error]

    transaction_success(transaction)
  end

  def buying?
    @currency_sent == 'USD' && @currency_received == 'BTC'
  end

  def calculate_amount_received
    btc_price = fetch_btc_price
    amount_received = @amount_sent / btc_price
    amount_received.round(8)
  end

  def calculate_usd_received
    btc_price = fetch_btc_price
    usd_received = @amount_sent * btc_price
    usd_received.round(2)
  end

  def create_transaction(amount_received)
    transaction = @user.transactions.build(amount_received: amount_received, amount_sent: @amount_sent,
                                           currency_received: @currency_received, currency_sent: @currency_sent,
                                           timestamp: Time.now)
    return transaction if transaction.valid?

    { error: transaction.errors.first.message }
  end

  def fetch_btc_price
    bitcoin_price_service = BitcoinPriceService.new
    price_data = bitcoin_price_service.fetch_data
    price_data['rate_float']
  end

  def not_enough_btc_founds
    selling? && @user.btc_balance < @amount_sent
  end

  def not_enough_usd_founds
    buying? && @user.balance < @amount_sent
  end

  def sell_btc
    return { error: 'Saldo insuficiente de BTC' } if not_enough_btc_founds

    usd_amount_received = calculate_usd_received
    transaction = create_transaction(usd_amount_received)
    return transaction if transaction[:error]

    transaction_success(transaction)
  end

  def selling?
    @currency_sent == 'BTC' && @currency_received == 'USD'
  end

  def transaction_success(transaction)
    if buying?
      @user.update!(balance: @user.balance - transaction.amount_sent,
                    btc_balance: @user.btc_balance + transaction.amount_received)
    end

    if selling?
      @user.update!(btc_balance: @user.btc_balance - @amount_sent,
                    balance: @user.balance + transaction.amount_received)
    end

    { success: 'Transaccion completada', transaction: transaction }
  end
end
