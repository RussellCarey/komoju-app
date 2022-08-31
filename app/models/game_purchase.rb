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
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases")
        puts data.inspect
    end

    def self.get_total_sales
        data = run_sql("SELECT COUNT(total) as total_sales FROM game_purchases")
        puts data.inspect
    end

    def self.get_total_sales_by(column, value)
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases WHERE #{column} = #{value}")
        puts data.inspect
    end

    def self.get_total_sales_between(min, man)
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases WHERE total < #{max} AND total > #{min}")
        puts data.inspect
    end

     def self.get_total_sales_between_dates(min_date, max_date)
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases WHERE created_at < #{max_date} AND created_at > #{min_date}")
        puts data.inspect
    end

    private 
    def run_sql(sql)
        return ActiveRecord::Base.connection.execute(sql)
        # formather
    end

end