class Purchase < ApplicationRecord
    belongs_to :user
    # has_one :product
end