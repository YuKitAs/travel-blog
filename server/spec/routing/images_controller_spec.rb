describe ImagesController, type: 'controller' do
  it{should route(:get, '/api/images').to(action: :index, format: :json)}
  it{should route(:get, '/api/images/1').to(action: :show, id: 1, format: :jpg)}
  it{should route(:get, '/api/images/1/thumbnail').to(action: :show_thumbnail, id: 1, format: :jpg)}
  it{should route(:post, '/api/images').to(action: :create, format: :json)}
  it{should route(:delete, '/api/images/1').to(action: :destroy, id: 1, format: :json)}
end
