json.ignore_nil! #don t marshal nil values 

# json.name            "hello"               <== useless when the following json.array! exist
# json.raceid          @race.id              <== useless when the following json.array! exist

json.array!(@entrants) do |entrant|
  json.partial! "result", :locals=>{ :result=>entrant } 
end



