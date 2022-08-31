class GamePurchase < ApplicationRecord
    validates :user_id, presence: true
    validates :total, presence: true
    validates :game_id, presence: true
    # validates :discount
    validates :total, presence: true
    # validates :status

    belongs_to :user

    #! ADD GENRE, PLATFORM etc onto the purchase...
    # Get total value of all games purchased / by gernre / by platform etc.
    def self.get_total_sales_amount
        sql = "SELECT game_id, SUM(total) as total FROM game_purchases"
        record = ActiveRecord::Base.connection.execute(sql)
        puts record[0].inspect
    end

    def self.get_total_sales
        sql = "SELECT COUNT(total) as total_sales FROM game_purchases"
        record = ActiveRecord::Base.connection.execute(sql)
        puts record[0].inspect
    end

    def self.get_total_sales_by(column, value)
        sql = "SELECT game_id, SUM(total) as total FROM game_purchases WHERE #{column} = #{value}"
        record = ActiveRecord::Base.connection.execute(sql)
        puts record.inspect
    end

    def self.get_total_sales_between(min, man)
        sql = "SELECT game_id, SUM(total) as total FROM game_purchases WHERE total < #{max} AND total > #{min}"
        record = ActiveRecord::Base.connection.execute(sql)
        puts record.inspect
    end

     def self.get_total_sales_between_dates(min_date, max_date)
        sql = "SELECT game_id, SUM(total) as total FROM game_purchases WHERE created_at < #{max_date} AND created_at > #{min_date}"
        record = ActiveRecord::Base.connection.execute(sql)
        puts record.inspect
    end
end