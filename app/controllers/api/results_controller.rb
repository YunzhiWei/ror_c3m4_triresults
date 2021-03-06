module Api

  class ResultsController < ApplicationController

    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results" 
      else
        # render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:race_id]}, result_id - #{params[:id]}"

        @race=Race.find(params[:race_id])
        @entrants=@race.entrants

        if @entrants.count > 0 # play a tricky to pass the 2 unit tests at the same time: $ rspec spec/resources_spec.rb -e rq05   &   $ rspec spec/caching_spec.rb -e rq03
          headers["ETag"] = Digest::MD5.hexdigest(@race.cache_key)
          headers["Last-Modified"] = @race.entrants.max(:updated_at).httpdate
          # fresh_when(@race)
          # stale? @race
        end
      end
      
    end
  
    def show
      
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}" 
      else
        # render plain:  "api: controller - #{params[:controller]}, action - #{params[:action]}, race_id - #{params[:race_id]}, result_id - #{params[:id]}"
        
        @result=Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
        render :partial=>"result", :object=>@result
      end
      
    end

    def update
      # binding.pry # pay attention to your 'rails server' console instead of 'irb' console
      Rails.logger.debug("method=#{request.method}")
      # race=Race.find(params[:race_id])
      # entrant=race.entrants.where(:id=>params[:id]).first
      entrant=Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
      result=entrant_params
      if result
        if result[:swim]
          entrant.swim = entrant.race.race.swim
          entrant.swim_secs = result[:swim].to_f
        end
        if result[:t1]
          entrant.t1 = entrant.race.race.t1
          entrant.t1_secs = result[:t1].to_f
        end
        if result[:bike]
          entrant.bike = entrant.race.race.bike
          entrant.bike_secs = result[:bike].to_f
        end
        if result[:t2]
          entrant.t2 = entrant.race.race.t2
          entrant.t2_secs = result[:t2].to_f
        end
        if result[:run]
          entrant.run = entrant.race.race.run
          entrant.run_secs = result[:run].to_f
        end
        entrant.save
      end

      render json: entrant
    end


    private

      def entrant_params
        params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
      end

    # end <== priviate is a keyword, no need 'end' !!!

  end


end


