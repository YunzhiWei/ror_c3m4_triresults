module Api

  class RacesController < ApplicationController

    protect_from_forgery with: :null_session

    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.debug exception
      render plain: "woops: we do not support that content-type[#{request.accept}]", status: :unsupported_media_type
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      if !request.accept || request.accept == "*/*"
        render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
      else
        render :status=>:not_found,
               :template=>"api/error_msg",
               :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]"}
      end
    end

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
        if params[:race]
          render plain:  "#{params[:race][:name]}"
        else
          render plain: :nothing, status: :ok
        end
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

    # end <== priviate is a keyword, no need 'end' !!!

  end
end