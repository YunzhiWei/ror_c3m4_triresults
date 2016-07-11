class RunResult < LegResult
  field :mmile, as: :minute_mile, type: Float

  def calc_ave
  	# p "RunResult:calc_ave - event, secs"
  	# pp event
  	# pp secs

    if event && secs
      # p "event.meters"
      # pp event.meters

  	  meters = event.meters
  	  self[:minute_mile] = meters.nil? ? nil : 12.1
  	end
  end
end
