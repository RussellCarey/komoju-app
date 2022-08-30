module ProductUtils 
    include ActiveSupport::Concern

    def calculate_price(game_id)
        game_data = get_game_data(game_id)
        game_data['rating'].to_f * 1000
    end

    private 
    def get_game_data(game_id)
        return JSON.parse(RestClient.get "https://rawg.io/api/games/#{game_id}", {params: {key: 'f0411c841de74da1818f464ffe5c0aa5'}})
    end
end