class Message < ApplicationRecord
  validates :user_id, presence: true
  validates :message, presence: true
  validates :username, presence: true
  belongs_to :user
end
