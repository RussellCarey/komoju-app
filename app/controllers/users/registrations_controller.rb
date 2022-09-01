# # https://github.com/heartcombo/devise/blob/main/app/controllers/devise_controller.rb
# # https://github.com/heartcombo/devise/blob/main/app/controllers/devise/registrations_controller.rb
# # Devise user defaults ["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at"] 
# class Users::RegistrationsController < Devise::RegistrationsController
#     # Control what to send to views
#     respond_to :json

#     private 
#     def respond_with(resource, _opts = {})
#         # Returns true if the record is persisted, i.e. it's not a new record and it was not destroyed, otherwise returns false.
#         # https://api.rubyonrails.org/classes/ActiveRecord/Persistence.html
#         # Will return an Auth header wit hthe jwt. Set on the front end as a cookie.
#         if resource.persisted?
#             register_success()
#         else 
#             register_failed()
#         end
#     end

#     def register_success

#         #! Change!
#         twillo_code = Twillo::Message.send(123123123, "Your registration code for Gamey is 12345")
#         puts twillo_code

#         render json: {
#             message: "Signed up",
#             # current_user works by storing id of current user in the application session.
#             user: current_user,
#         }, status: :ok
#     end

#     def register_failed 
#         puts resource.errors.messages
#         render json: {
#             errors: resource.errors.messages
#         }, status: 500
#     end

# end

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end
  def register_success
    render json: { message: 'Signed up.' }
  end
  def register_failed
    render json: { message: "Signed up failure." }
  end
end