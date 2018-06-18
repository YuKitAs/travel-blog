json.id(place._id)
json.name(place.name)
json.location do
  json.lat(place.location[1])
  json.lng(place.location[0])
end
