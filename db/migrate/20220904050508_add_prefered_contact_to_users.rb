class AddPreferedContactToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :prefered_contact, :integer
  end
end
