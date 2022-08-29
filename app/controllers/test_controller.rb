class TestController < ApplicationController

    def webhook
        data = JSON.parse(request.body.read())
        puts data['type']
    end
end