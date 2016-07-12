class RacerInfo
  include Mongoid::Document
  field :fn,  as: :first_name, type: String
  field :ln,  as: :last_name,  type: String
  field :g,   as: :gender,     type: String
  field :yr,  as: :birth_year, type: Integer
  field :res, as: :residence,  type: Address

  field :racer_id, as: :_id						# added manually
  field :_id, default:->{ racer_id }			# added manually

  embedded_in :parent, polymorphic: true 

  validates_presence_of :first_name, :last_name, :gender, :birth_year
  validates_inclusion_of :gender, :in=>%w{M F}
  validates_numericality_of :birth_year, :less_than=>Date.current.year, :only_integer=>true

  # the following is a example to explain how to write the general functions of 'city' and 'city='
  # def city
  #   self.residence ? self.residence.city : nil
  # end
  # def city= name
  #   object=self.residence ||= Address.new
  #   object.city=name
  #   self.residence=object
  # end

  # actually, we need not only 'city' and 'city=' functions, we need 'state' and 'state=' functions
  # But this time, we will leverage Ruby's magic to do it
  # Please search for 'metaprogramming' and 'define_method' for more details
  ["city", "state"].each do |action|
    define_method("#{action}") do
      self.residence ? self.residence.send("#{action}") : nil
    end
    
    define_method("#{action}=") do |name|
      object=self.residence ||= Address.new
      object.send("#{action}=", name)
      self.residence=object
    end
  end

end


# point=Point.demongoize(:type=>"Point", :coordinates=>[-122.27, 37.8])
# address=Address.demongoize(:city=>"Oakland", :state=>"CA", :loc=>point.mongoize)
