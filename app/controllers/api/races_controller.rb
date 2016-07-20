module Api

  class RacesController < ApplicationController

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      if !request.accept || request.accept == "*/*"
        render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
      else
        render :status=>:not_found,
               :template=>"api/error_msg",
               :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]"}
      end
    end

    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == "*/*"
        # render plain: "/api/races"
        render plain:  "/#{params[:controller]}, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}"
      end
      
    end
  
    def show      
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}" 
      else
        # binding.pry # pay attention to your 'rails server' console instead of 'irb' console
        # render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:id]}"
        race=Race.find(params[:id])
        render race
      end
      
    end

    def create
      if !request.accept || request.accept == "*/*"
        # render plain: :nothing, status: :ok
        render plain:  "#{params[:race][:name]}"
      else
        # binding.pry # pay attention to your 'rails server' console instead of 'irb' console
        # render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:id]}"
        race=Race.create(race_params)
        render plain:  "#{params[:race][:name]}", status: :created
      end
    end

    def update
      # binding.pry # pay attention to your 'rails server' console instead of 'irb' console
      Rails.logger.debug("method=#{request.method}")
      race=Race.find(params[:id])
      inputpara=race_params
      inputpara.each do |k,v|
        race[k] = v
      end
      render json: race
    end

    def destroy
      # binding.pry # pay attention to your 'rails server' console instead of 'irb' console
      race=Race.find(params[:id])
      race.destroy
      render :nothing => true, :status => :no_content
    end

    private

      def race_params
        params.require(:race).permit(:name, :date)
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