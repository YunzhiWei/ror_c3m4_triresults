class LegResult
  include Mongoid::Document
  field :secs, type: Float

  def calc_ave
  	#
  end

  after_initialize do |doc|
  	# calc_ave
  end
  
  def secs= value
  	self[:secs] = value

  	calc_ave
  end
end