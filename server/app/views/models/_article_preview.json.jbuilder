json.id(article._id)
json.title(article.title)
json.date(article.date)
json.introduction(article.introduction)
json.place do
  json.partial!('models/place', place: article.place)
end
json.tags do
  json.array!(article.tags, partial: 'models/tag', as: :tag)
end
json.thumbnail_id(article.thumbnail_id)
