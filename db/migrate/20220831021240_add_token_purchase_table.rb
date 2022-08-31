class AddTokenPurchaseTable < ActiveRecord::Migration[7.0]
  def change
    create_table :token_purchases do |t|
      t.float :amount, null: false
      t.integer :discount, default: 0
      t.float :total, null: false
      t.integer :status, default: 0
      t.timestamps
    end
    add_reference :token_purchases, :user, foreign_key: true
  end
end
