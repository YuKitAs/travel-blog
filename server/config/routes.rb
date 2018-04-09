Rails.application.routes.draw do
  get 'api/articles' => 'articles#index'
  get 'api/articles/:id' => 'articles#show'
  post 'api/articles' => 'articles#create'
  put 'api/articles/:id' => 'articles#update'
  delete 'api/articles/:id' => 'articles#destroy'
end
