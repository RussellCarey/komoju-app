class AddAuthorizedAtOnUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :authorized_at, :datetime
  end
end
