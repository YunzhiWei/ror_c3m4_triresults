class TriResultsWS < ApplicationController
  include HTTParty

  debug_output $stdout
  base_uri "http://localhost:3000"
  
end

