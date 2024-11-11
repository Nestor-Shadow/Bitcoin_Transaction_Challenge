class AddBtcBalanceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :btc_balance, :decimal, precision: 15, scale: 8, default: 0.0
  end
end
