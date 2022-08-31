class Favourite < ApplicationRecord
    validates :user_id, presence: true
    validates :game_id, presence: true

    belongs_to :user

    # Get list of items in favourites currently

    # Get total value of items in favourites currently
end


