class TokenPurchaseController < ApplicationController
    
    before_action :authorize_request
    before_action :check_owner, only: %i[]

    def index

    end

    def show 

    end

    def create 

    end

    def update 

    end

    def destory 

    end

    # https://webhookrelay.com/v1/examples/receiving-webhooks-on-localhost.html -- relay forward --bucket KOMOJU http://localhost:3000/komoju/webhook
    # https://docs.komoju.com/en/webhooks/overview/#events
    def webhook 
        request_body = request.body.read
        signature = OpenSSL::HMAC.hexdigest('sha256', Rails.application.credentials.twilio[:sid], request_body)
        return 400 unless Rack::Utils.secure_compare(signature, request.env["HTTP_X_KOMOJU_SIGNATURE"])

        #! Handle events here..
        puts request_body.inspect
    end

    def aggregate
        f = params['func']
        data = TokenPurchase.send("#{f}", aggregate_params)
        render json: { data:  data }, status: :ok
    end

    private
    def token_params
        params.fetch(:token_purchase, {}).permit()
    end

    def aggregate_params
        params.permit(:func, :min, :max, :min_date, :max_date, :column, :value)
    en

    def check_owner
        ##
    end
end