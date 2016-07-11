class Event
  include Mongoid::Document
  field :o, as: :order,    type: Integer
  field :n, as: :name,     type: String
  field :d, as: :distance, type: Float
  field :u, as: :units,    type: String

  def meters
  	case units
  	when "kilometers" then return 1000 * distance
  	when "meters" then return distance
  	when "miles" then return 1609.344 * distance
  	when "yards" then return 0.9144 * distance
  	else nil
  	end
  end

  def miles
  	case units
  	when "kilometers" then return 0.621371 * distance
  	when "meters" then return 0.000621371 * distance
  	when "miles" then return distance
  	when "yards" then return 0.000568182 * distance
  	else nil
  	end
  end
end
