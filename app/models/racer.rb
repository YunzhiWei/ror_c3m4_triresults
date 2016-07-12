class Racer
  include Mongoid::Document

  embeds_one :info, class_name: 'RacerInfo', as: :parent, autobuild: true
  has_many :races, class_name: 'Entrant', foreign_key: "racer.racer_id", dependent: :nullify, order: :"race.date".desc

  before_create do |racer| 
  	racer.info.id = racer.id
  end
end

# racer=Racer.new
# racer.build_info(fn:"cat", ln:"inhat", g:"M", yr:1940, res:address)
