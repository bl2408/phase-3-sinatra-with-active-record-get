class ApplicationController < Sinatra::Base

  set :default_content_type, "application/json"

  get '/' do
    { message: "Hello world" }.to_json
  end
  get '/games' do
    Game.all.to_json
  end

  get '/games/:id' do
    id = params["id"].to_i
    game = Game.find(id)
    game.to_json(
      only: [:id, :title, :genre, :price], 
      include: {
        reviews: { only: [:comment, :score], 
          include: { 
            user: { only: [:name] }
          } 
        }
      })
  end
end
