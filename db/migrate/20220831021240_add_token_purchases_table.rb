class AddTokenPurchasesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :token_purchases do |t|
      t.user_id :jti, null: false
      t.float :amount, null: false
      t.integer :discount, default: 0
      t.float :total, null: false
      t.timestamps
    end
  end
end
