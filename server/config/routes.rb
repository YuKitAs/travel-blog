Rails.application.routes.draw do
  get 'api/articles(:tag_id)' => 'articles#index'
  get 'api/articles/:id' => 'articles#show'
  post 'api/articles' => 'articles#create'
  put 'api/articles/:id' => 'articles#update'
  delete 'api/articles/:id' => 'articles#destroy'

  get 'api/places' => 'places#index'
  get 'api/places/:id' => 'places#show'
  post 'api/places' => 'places#create'
  put 'api/places/:id' => 'places#update'
  delete 'api/places/:id' => 'places#destroy'

  get 'api/tags(:article_id)' => 'tags#index'
  get 'api/tags/:id' => 'tags#show'
  post 'api/tags' => 'tags#create'
  put 'api/tags/:id' => 'tags#update'
  delete 'api/tags/:id' => 'tags#destroy'

  get 'api/images/:id' => 'images#show'
  post 'api/images' => 'images#create'
  delete 'api/images/:id' => 'images#destroy'

  post 'login(:username&:password)' => 'authentication#login'
end
