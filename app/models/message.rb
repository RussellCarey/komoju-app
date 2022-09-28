class Message < ApplicationRecord
  validates :user_id, presence: true
  validates :message, presence: true

  belongs_to :user
end
