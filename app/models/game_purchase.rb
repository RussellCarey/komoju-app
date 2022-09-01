class GamePurchase < ApplicationRecord
    validates :user_id, presence: true
    validates :total, presence: true
    validates :game_id, presence: true
    validates :name, presence: true
    validates :image, presence: true
    # validates :discount
    # validates :status

    belongs_to :user

    # ["id", "game_id", "discount", "total", "status", "created_at", "updated_at", "user_id"] 
    #! ADD GENRE, PLATFORM etc onto the purchase...
    # Get total value of all games purchased / by gernre / by platform etc.
        
    # Aggregate data
    def self.total_sales_amount(params)
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases")
    end

    def self.total_sales(params)
        data = run_sql("SELECT COUNT(total) as total_sales FROM game_purchases")
    end

    def self.total_sales_by(params)
        column = params['column']
        value = params['value']
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases WHERE #{column} = #{value}")
    end

    def self.total_sales_between(params)
        min = params['min']
        max = params['max']
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases WHERE total < #{max} AND total > #{min}")
    end

     def self.total_sales_between_dates(params)
        min_date = params['min_date']
        max_date = params['max_date']
        data = run_sql("SELECT game_id, SUM(total) as total FROM game_purchases WHERE created_at < #{max_date} AND created_at > #{min_date}")
    end

    private
    def self.run_sql(sql)
        data = ActiveRecord::Base.connection.execute(sql)
        return data
    end

end