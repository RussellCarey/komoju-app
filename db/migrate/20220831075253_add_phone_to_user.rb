class AddPhoneToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :integer, null: true
  end
end
