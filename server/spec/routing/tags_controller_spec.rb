describe TagsController, type: 'controller' do
  it{should route(:get, '/api/tags').to(action: :index, format: :json)}
  it{should route(:get, '/api/tags/1').to(action: :show, id: 1, format: :json)}
  it{should route(:post, '/api/tags').to(action: :create, format: :json)}
  it{should route(:put, '/api/tags/1').to(action: :update, id: 1, format: :json)}
  it{should route(:delete, '/api/tags/1').to(action: :destroy, id: 1, format: :json)}
end
