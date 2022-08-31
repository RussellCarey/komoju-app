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
    post '/create_token', to: 'komoju/token#create_payment_token'

    # KOMOJU Payment
    post '/make_payment', to: "komoju/payment#make_payment"
    post '/make_payment_no_token', to: "komoju/payment#make_payment_no_token"
    get '/get_all_payments', to: "komoju/payment#get_all_user_payment_data"
    get '/get_payment_data/:id', to: 'komoju/payment#get_payment_data'
    post '/cancel/:id', to: 'komoju/payment#cancel_payment'

    # KOMOJU Subscriptions
    post '/subscriptions', to: 'komoju/subscription#create'
    get '/subscriptions/:id', to: 'komoju/subscription#get_one'
    delete '/subscriptions/:id', to: 'komoju/subscription#stop' # NOT FOUND?! CHECK

    # KOMOJU Customers
    post '/customers', to: 'komoju/customer#create'
    patch '/customers/:id', to: 'komoju/customer#update_payment_details'
    delete '/customers/:id', to: 'komoju/customer#destroy'

    # Purchase
    get '/purchases', to: 'game_purchase#show_all'
    post '/purchases', to: 'game_purchase#create'
    delete '/purchases/:id', to: 'game_purchase#destroy'
    patch '/purchases/:id', to: 'game_purchase#update'

    # Favourites
    get '/favourites', to: 'favourites#show_all'
    post '/favourites', to: 'favourites#create'
    delete '/favourites/:id', to: 'favourites#destroy'

    # Cart
    get '/cart', to: 'cart#show_all'
    post '/cart', to: 'cart#create'
    delete '/cart/:id', to: 'cart#destroy'
end