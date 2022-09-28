class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :message, null: false
      t.boolean :blocked, default: false
      t.timestamps
    end
    add_reference :messages, :user, foreign_key: true
  end
end
