#Notes : https://egghead.io/lessons/ruby-on-rails-add-custom-fields-to-a-devise-user-model-with-a-ruby-on-rails-migration
# https://btihen.me/post_ruby_rails/rails_devise_users_namespaced/

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, length: { minimum: 6, maximum: 12 }
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2}
  validates_confirmation_of :password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :jwt_authenticatable,
  jwt_revocation_strategy: JwtDenylist
  #  :recoverable, :rememberable, :validatable

  has_many :favourites
  has_many :carts
  has_many :token_purchases
  has_many :game_purchases
end