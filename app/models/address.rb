class Address
  attr_accessor :city, :state, :location

  def initialize(city=nil, state=nil, loc=nil)
    @city  = city
    @state = state
    @location = loc ? Point.new(loc[0], loc[1]) : nil
  end

  #creates a DB-form of the instance
  def mongoize
    {:city=>@city, :state=>@state, :loc=>@location.mongoize}
  end
  
  #creates an instance of the class from the DB-form of the data
  def self.demongoize(object)
    case object
    when nil then nil
    else
      Address.new(object[:city], object[:state], object[:loc] ? object[:loc][:coordinates] : nil)
    end
  end

  #takes in all forms of the object and produces a DB-friendly form
  def self.mongoize(object) 
    case object
    when nil then nil
    when Hash then 
      if object[:type] #in GeoJSON Address format
          Address.new(object[:city], object[:state], object[:loc][:coordinates]).mongoize
      else       #in legacy format
          Address.new(object[:city], object[:state], object[:loc][:coordinates]).mongoize
      end
    when Address then object.mongoize
    else object
    end
  end
  
  #used by criteria to convert object to DB-friendly form
  def self.evolve(object)
    case object
    when Address then object.mongoize
    else object
    end
  end
end
