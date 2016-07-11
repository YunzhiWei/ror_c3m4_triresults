class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant

  embeds_one :event, as: :parent

  validates_presence_of :event

  def calc_ave
  	#
  	# p "LegResult:calc_ave"

  end

  after_initialize do |doc|
  	# p "LegResult:after_initialize"
  	calc_ave
  end
  
  def secs= value
  	# p "LegResult:secs="

  	self[:secs] = value

  	calc_ave
  end
end
