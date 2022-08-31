class TokenPurchase < ApplicationRecord
    validates :user_id, presence :true
    validates :amount, presence :true
    validates :discount, default: 0
    validates :total, presence :true
    validates :status default: 0

    belongs_to :user
    
end