class Favourite < ApplicationRecord
    validates :user_id, presence: true
    validates :game_id, presence: true

    belongs_to :user
end
