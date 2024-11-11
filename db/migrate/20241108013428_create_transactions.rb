class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount_sent
      t.decimal :amount_received
      t.string :currency_sent
      t.string :currency_received
      t.datetime :timestamp

      t.timestamps
    end
  end
end
