class AddNameImageAndPriceToCartAndFavourites < ActiveRecord::Migration[7.0]
  def change
    add_column :favourites, :image, :string, null: false
    add_column :favourites, :name, :string, null: false
    add_column :favourites, :price, :float, null: false

    add_column :carts, :image, :string, null: false
    add_column :carts, :name, :string, null: false
    add_column :carts, :price, :float, null: false
  end
end
