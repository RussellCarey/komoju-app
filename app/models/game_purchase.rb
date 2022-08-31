class GamePurchase < ApplicationRecord
    validates :user_id, presence: true
    validates :amount, presence: true
    validates :game_id, presence: true
    # validates :discount
    validates :total, presence: true
    # validates :status

    belongs_to :user
end