class CreatePurchasesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.integer :order_id, null: false, unique: true
      t.float :total, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
