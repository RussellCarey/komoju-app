class GamePurchaseController < ApplicationController

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

    private
    def params
        params.fetch(:game_purchase, {}).permit()
    end

    def check_owner
        ##
    end
end