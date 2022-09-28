require "jwt"

module JsonWebToken
  SECRET_KEY = Rails.env.development? ? Rails.application.credentials.devise[:jwt_secret] : ENV["JWT_SECREY"]

  #
  def self.encode(payload, exp = 10.seconds.from_now)
    payload[:exp] = exp.to_i
    token = JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
