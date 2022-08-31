class AddFavouritesJoinTable < ActiveRecord::Migration[7.0]
  def change
     create_table :favourites do |t|
      t.string :game_id, null: false
      t.timestamps
    end
      add_reference :favourites, :user, foreign_key: true
  end
end
