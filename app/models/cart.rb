class Cart < ApplicationRecord
  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :image, presence: true
  validates :name, presence: true
  validates :price, presence: true

  belongs_to :user

  #Aggregate scopes
  scope :in_carts_total_value, -> { calculate(:sum, :price) }

  #Aggregate data
  def self.in_cart(params)
    data =
      run_sql(
        "
            SELECT name, game_id, COUNT (game_id) as total_in, SUM(price) as total_value
            FROM carts
            GROUP BY game_id
            "
      )
  end

  private

  def self.run_sql(sql)
    data = ActiveRecord::Base.connection.execute(sql)
    return data
  end
end
