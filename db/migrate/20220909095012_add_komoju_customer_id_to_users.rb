class AddKomojuCustomerIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :komoju_customer, :string
  end
end
