json.id(article._id)
json.title(article.title)
json.date(article.date)
json.introduction(article.introduction)
json.place do
  json.partial!('models/place', place: article.place) if article.place
end
json.tags do
  json.array!(article.tags, partial: 'models/tag', as: :tag) if article.tags
end
json.thumbnail do
  json.partial!('models/thumbnail', thumbnail: article.thumbnail) if article.thumbnail
end
