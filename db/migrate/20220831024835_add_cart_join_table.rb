class AddCartJoinTable < ActiveRecord::Migration[7.0]
  def change
     create_table :carts do |t|
      t.string :game_id, null: false
      t.timestamps
    end
      add_reference :carts, :user, foreign_key: true
  end
end
