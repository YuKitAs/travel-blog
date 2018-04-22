Rails.application.routes.draw do
  get 'api/articles' => 'articles#index'
  get 'api/articles/:id' => 'articles#show'
  post 'api/articles' => 'articles#create'
  put 'api/articles/:id' => 'articles#update'
  delete 'api/articles/:id' => 'articles#destroy'

  get 'api/places' => 'places#index'
  get 'api/places/:id' => 'places#show'
  post 'api/places' => 'places#create'
  put 'api/places/:id' => 'places#update'
  delete 'api/places/:id' => 'places#destroy'

  post 'login(:username&:password)' => 'authentication#login'
end
