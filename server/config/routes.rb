Rails.application.routes.draw do
  get 'api/articles' => 'articles#index'
  get 'api/articles/:article_id' => 'articles#show'
end
