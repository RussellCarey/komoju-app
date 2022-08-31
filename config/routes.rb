Rails.application.routes.draw do
  # devise_for is meant to play nicely with other routes methods. 
  # For example, by calling devise_for inside a namespace, it automatically nests your devise controllers.
  devise_for :users,
  # Added defaults to stop flash error
  defaults: { format: :json },
  # Usually point to devise controllers. Custom. You can remove _controller.
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # KOMOJU Token
    post '/create_token', to: 'token#create_payment_token'

    # KOMOJU Payment
    get '/get_all_payments', to: "payment#get_all_user_payment_data"
    get '/get_payment_data/:payment_id', to: 'payment#get_payment_data'
end
