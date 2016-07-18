module Api

  class RacersController < ApplicationController

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

  class EntriesController < ApplicationController

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}/entries" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, racer_id - #{params[:racer_id]}, entry_id - #{params[:id]}"
      end
      
    end
  
    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, racer_id - #{params[:racer_id]}, entry_id - #{params[:id]}"
      end
      
    end

  end

end