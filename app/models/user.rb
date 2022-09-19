#Notes : https://egghead.io/lessons/ruby-on-rails-add-custom-fields-to-a-devise-user-model-with-a-ruby-on-rails-migration
# https://btihen.me/post_ruby_rails/rails_devise_users_namespaced/
# https://www.loginradius.com/blog/engineering/guest-post/jwt-vs-sessions/

class User < ApplicationRecord
  before_validation :generate_user_reg_number

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, length: { minimum: 6, maximum: 12 }, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :reg_token, presence: true
  validates :prefered_contact, inclusion: { in: [0, 1] }
  # validates :authorized_at
  validates_confirmation_of :password

  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :favourites
  has_many :carts
  has_many :token_purchases
  has_many :game_purchases

  # Mailing should be on the controller?
  def add_tokens_to_user(amount)
    self.token_count += amount

    if self.save
      return true
    else
      puts self.errors.full_messages
      return false
    end
  end

   def remove_tokens_from_user(amount)
    self.token_count -= amount

    if self.save
      return true
    else
      puts self.errors.full_messages
      return false
    end
  end

  def generate_user_reg_number
    self.reg_token = rand(0..9_999_999)
  end

  def activate_user
    self.authorized_at = DateTime.now
  end
end
