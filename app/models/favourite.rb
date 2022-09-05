class Favourite < ApplicationRecord
  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :image, presence: true
  validates :name, presence: true
  validates :price, presence: true

  belongs_to :user

  # Aggregate data
  def self.in_favourites(params)
    data =
      run_sql(
        "
          SELECT name, game_id, COUNT (game_id) as total_in, SUM(price) as total_value
          FROM favourites
          GROUP BY game_id
        "
      )
  end

  def self.total_sales_between(params)
    min = params["min"]
    max = params["max"]
    data = run_sql("SELECT game_id, SUM(total) as total FROM favourites WHERE total < #{max} AND total > #{min}")
  end

  def self.total_sales_between_dates(params)
    min_date = params["min_date"]
    max_date = params["max_date"]
    data = run_sql("SELECT game_id, SUM(total) as total FROM favourites WHERE created_at < #{max_date} AND created_at > #{min_date}")
  end

  private

  def self.run_sql(sql)
    data = ActiveRecord::Base.connection.execute(sql)
    return data
  end
end
