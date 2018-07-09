describe ArticlesController, type: 'controller' do
  it{should route(:get, '/api/articles/featured/preview').to(action: :show_featured_preview, format: :json)}
  it{should route(:put, '/api/articles/featured/1').to(action: :update_featured, id: 1, format: :json)}

  it{should route(:get, '/api/articles/preview').to(action: :index_preview, format: :json)}
  it{should route(:get, '/api/articles/1/full').to(action: :show_full, id: 1, format: :json)}
  it{should route(:post, '/api/articles').to(action: :create, format: :json)}
  it{should route(:put, '/api/articles/1').to(action: :update, id: 1, format: :json)}
  it{should route(:delete, '/api/articles/1').to(action: :destroy, id: 1, format: :json)}
end
