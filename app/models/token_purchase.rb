class TokenPurchase < ApplicationRecord
    validates :user_id, presence: true
    validates :amount, presence: true
    # validates :discount
    validates :total, presence: true
    # validates :status

    belongs_to :user

    # Get data for token sales, total and eg. 100 - 500, 500 - 1000 etc...

    # def self.get_total_sales
    #     sql = "SELECT amount, SUM(total) FROM token_purchases"
    #     record = ActiveRecord::Base.connection.execute(sql)
    #     puts record
    # end
end
