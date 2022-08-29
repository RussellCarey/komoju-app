class CreateJwtDenylist < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
      t.timestamps
    end
    # Table indexes are commonly made by using one column in a table
    # add_index(table_name, column_name, options = {}) public
    add_index :jwt_denylist, :jti
  end
end
