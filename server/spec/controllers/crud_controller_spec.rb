class Value
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :value, type: String
  validates(:value, presence: { message: 'cannot be empty' }, uniqueness: { message: 'must be unique' })
end

class ValuesController < CrudController
  def entity_class
    return Value
  end

  def entity_params
    params.permit(:value)
  end

  def render_entities(values, status)
    render(json: values.map{|value| { value: value.value }}, status: status)
  end

  def render_entity(value, status)
    render(json: { value: value.value }, status: status)
  end
end

RSpec.describe ValuesController, type: 'controller' do
  before do
    Rails.application.routes.draw do
      get '/values', to: 'values#index'
      get '/values/:id', to: 'values#show'
      post '/values', to: 'values#create'
      put '/values/:id', to: 'values#update'
      delete '/values/:id', to: 'values#destroy'
    end

    Value.new(value: 'VALUE_1').save!
    Value.new(value: 'VALUE_2').save!
  end

  after do
    Rails.application.reload_routes!
  end

  describe 'with user not logged in' do
    it 'returns all values on GET values' do
      get :index
      values = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(values.size).to eq 2
      expect(values).to eq [{ 'value' => 'VALUE_1' }, { 'value' => 'VALUE_2' }]
    end

    it 'returns unauthorized on POST value' do
      post :create, params: { value: 'VALUE_3' }
      value = JSON.parse(response.body)

      expect(response).to have_http_status(:unauthorized)
      expect(value).to eq('error' => 'unauthorized', 'message' => '')
    end
  end

  describe 'with user logged in' do
    before :each do
      login
    end

    it 'adds a value into database on POST value' do
      post :create, params: { value: 'VALUE_3' }
      value = JSON.parse(response.body)

      expect(response).to have_http_status(:created)
      expect(value).to eq('value' => 'VALUE_3')
    end

    it 'returns bad request on POST value' do
      post :create, params: { value: '' }
      value = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(value).to eq(
        'error' => 'bad_request',
        'message' => 'The following errors were found: Value cannot be empty'
      )
    end
  end
end
