#Notes : https://egghead.io/lessons/ruby-on-rails-add-custom-fields-to-a-devise-user-model-with-a-ruby-on-rails-migration
# https://btihen.me/post_ruby_rails/rails_devise_users_namespaced/

class User < ApplicationRecord
  attr_accessor :unhashed_password
  attr_accessor :hased_password
  attr_accessor :password

  # CHeck
  enum prefered_contact: [:mobile, :email]

  before_validation :generate_user_reg_number

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, length: { minimum: 6, maximum: 12 }, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2}
  validates :reg_token, presence: true
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

  def generate_user_reg_number
    self.reg_token = rand(0..9999999)
  end

  def activate_user
    self.authorized_at = DateTime.now
  end
end