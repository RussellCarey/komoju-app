class AddGamePurchaseTable < ActiveRecord::Migration[7.0]
  def change
    create_table :game_purchases do |t|
      t.string :game_id, null: false
      t.integer :discount, default: 0
      t.float :total, null: false
      t.integer :status, default: 0

      t.timestamps
    end
    add_reference :game_purchases, :user, foreign_key: true
  end
end
