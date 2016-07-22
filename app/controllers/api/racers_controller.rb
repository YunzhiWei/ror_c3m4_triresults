module Api

  class RacersController < ApplicationController

    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, racer_id - #{params[:id]}"
      end
    
    end
  
    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:id]}" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, racer_id - #{params[:id]}"
      end
    end

  end

end