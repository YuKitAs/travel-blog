Rails.application.routes.draw do
  scope '/api', defaults: { format: :json } do
    post '/login', to: 'authentication#login'

    get '/articles/featured', to: 'articles#show_featured'
    put '/articles/featured/:id', to: 'articles#update_featured'

    get '/articles', to: 'articles#index'
    get '/articles/:id', to: 'articles#show'
    post '/articles', to: 'articles#create'
    put '/articles/:id', to: 'articles#update'
    delete '/articles/:id', to: 'articles#destroy'

    get '/images', to: 'images#index'
    get '/images/:id', to: 'images#show', defaults: { format: :jpg }
    get '/images/:id/thumbnail', to: 'images#show_thumbnail', defaults: { format: :jpg }
    post '/images', to: 'images#create'
    delete '/images/:id' => 'images#destroy'

    get '/places', to: 'places#index'
    get '/places/:id', to: 'places#show'
    post '/places', to: 'places#create'
    put '/places/:id', to: 'places#update'
    delete '/places/:id', to: 'places#destroy'

    get '/tags', to: 'tags#index'
    get '/tags/:id', to: 'tags#show'
    post '/tags', to: 'tags#create'
    put '/tags/:id', to: 'tags#update'
    delete '/tags/:id', to: 'tags#destroy'
  end
end
