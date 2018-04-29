require_relative '../utils/fixture_reader'

RSpec.describe PlacesController, type: :controller do
  before :each do
    @places = read_json('places.json')
    @place = @places['place']
    @new_place = @places['new_place']

    @place_id = Place.create!(@place).to_param
  end

  describe 'GET #index' do
    it 'lists all places' do
      get :index
      places = JSON.parse(response.body)
      place = places.first

      expect(response.message).to eq 'OK'

      expect(places.size).to be 1

      expect(place['name']).to eq @place['name']
      expect(place['location'].first.to_s).to eq @place['location']['lng']
      expect(place['location'].second.to_s).to eq @place['location']['lat']
    end
  end

  describe 'GET #show' do
    it 'shows a single place by id' do
      get :show, params: { id: @place_id }
      place = JSON.parse(response.body)

      expect(response.message).to eq 'OK'

      expect(place['name']).to eq @place['name']
      expect(place['location'][0].to_s).to eq @place['location']['lng']
      expect(place['location'][1].to_s).to eq @place['location']['lat']
    end
  end

  describe 'POST #create' do
    context 'with authorization' do
      it 'creates a new place' do
        login

        post :create, params: { place: @new_place }
        new_place = JSON.parse(response.body)

        expect(response.message).to eq 'Created'

        expect(Place.all.size). to be 2

        expect(new_place['name']).to eq @new_place['name']
        expect(new_place['location'][0].to_s).to eq @new_place['location']['lng']
        expect(new_place['location'][1].to_s).to eq @new_place['location']['lat']
      end
    end

    context 'without authorization' do
      it 'does not create place' do
        post :create, params: { place: @new_place }

        expect(response.message).to eq 'Unauthorized'
      end
    end
  end

  describe 'PUT #update' do
    context 'with authorization' do
      it 'updates a new place' do
        login

        put :update, params: { id: @place_id, place: @new_place }
        place = Place.find(@place_id)

        expect(place['name']).to eq @new_place['name']
        expect(place['location'][0].to_s).to eq @new_place['location']['lng']
        expect(place['location'][1].to_s).to eq @new_place['location']['lat']
      end
    end

    context 'without authorization' do
      it 'does not update place' do
        put :update, params: { id: @place_id, place: @new_place }

        expect(response.message).to eq 'Unauthorized'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with authorization' do
      it 'deletes an place by id' do
        login

        delete :destroy, params: { id: @place_id }

        expect(Place.all).to be_empty
      end
    end

    context 'without authorization' do
      it 'does not delete place' do
        delete :destroy, params: { id: @place_id }

        expect(response.message).to eq 'Unauthorized'
      end
    end
  end
end

private

def login
  allow(AuthorizeApiRequest).to receive_message_chain(:call, :result){:user}
end
