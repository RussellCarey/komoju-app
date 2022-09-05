# file: app/controllers/unauthenticated_controller.rb
module Errors
  class UnauthenticatedController < ActionController::Metal
    def self.call(env)
      @respond ||= action(:respond)
      @respond.call(env)
    end

    def respond
      self.status = :unauthorized
      self.content_type = "application/json"
      self.response_body = { errors: ["Unauthorized Request, is the token correct or present?"] }.to_json
    end
  end
end
