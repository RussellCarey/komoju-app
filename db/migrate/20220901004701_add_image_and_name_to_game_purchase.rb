class AddImageAndNameToGamePurchase < ActiveRecord::Migration[7.0]
  def change
    add_column :game_purchases, :image, :string, null: false
    add_column :game_purchases, :name, :string, null: false
  end
end
