class AddUsernameToMessges < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :username, :string, null: false
  end
end
