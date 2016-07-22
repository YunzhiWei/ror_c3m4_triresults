module Api

  class ResultsController < ApplicationController

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results" 
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:race_id]}, result_id - #{params[:id]}"
      end
      
    end
  
    def show
      
      @result=Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first

      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}" 
      else
        # render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:race_id]}, result_id - #{params[:id]}"
        render :partial=>"result", :object=>@result
      end
      
    end

  end


end