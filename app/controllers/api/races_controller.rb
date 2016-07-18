module Api

  class RacesController < ApplicationController

    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}"
      end
      
    end
  
    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:id]}"
      end
      
    end

    def create
      if !request.accept || request.accept == "*/*"
        render plain: :nothing, status: :ok
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:id]}"
      end
      
    end

  end

  class ResultsController < ApplicationController

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:race_id]}, result_id - #{params[:id]}"
      end
      
    end
  
    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:race_id]}, result_id - #{params[:id]}"
      end
      
    end

  end


end