class RunResult < LegResult
  field :mmile, as: :minute_mile, type: Float

  def calc_ave
  	# p "RunResult:calc_ave - event, secs"
  	# pp event
  	# pp secs

    if event && secs
      # p "event.meters"
      # pp event.meters

  	  miles = event.miles
  	  self[:minute_mile] = miles.nil? ? nil : (secs/60)/miles
  	end
  end
end
