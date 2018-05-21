require_relative '../utils/fixture_reader'

RSpec.describe ImagesController, type: :controller do
  before :each do
    @image_id = Image.create!(
      content: BSON::Binary.new(image_stream.read),
      thumbnail: { 'id': 'valid-thumbnail-id-01', 'width': 300, 'height': 222 },
      created_at: Time.at(1_514_764_800)
    ).to_param
  end

  describe 'GET #index' do
    it 'lists image representations within a given range' do
      new_image_id = Image.create!(
        content: BSON::Binary.new,
        thumbnail: { 'id': 'valid-thumbnail-id-01', 'width': 300, 'height': 222 },
        created_at: Time.at(1_514_592_000)
      ).to_param

      get :index, params: { start: 1, limit: 1 }
      images = JSON.parse(response.body)

      expect(response.message).to eq 'OK'

      expect(images.size).to eq 1

      expect(images.first['id']).to eq new_image_id
    end
  end

  describe 'GET #show' do
    it 'shows a single image by id' do
      get :show, params: { id: @image_id }

      expect(response.message).to eq 'OK'
      expect(response.body).to eq image_stream.read
    end
  end

  describe 'POST #create' do
    context 'with authorization' do
      it 'creates a new image with jpg format' do
        login

        post :create, params: { image: image_stream }

        image = JSON.parse(response.body)
        stored_image = Image.find(image['id'])

        expect(response.message).to eq 'Created'
        expect(image['id']).to be_uuid

        expect(Image.all.size).to be 2
        expect(stored_image.thumbnail.width).to be 300
        expect(stored_image.thumbnail.height).to be 222
      end

      it 'does not create image with other format' do
        login

        post :create, params: { image: Rack::Test::UploadedFile.new(get_fixture('testtu.png'), 'image/png') }

        expect(response.message).to eq 'Bad Request'
      end
    end

    context 'without authorization' do
      it 'does not create image' do
        post :create, params: { image: image_stream }

        expect(response.message).to eq 'Unauthorized'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with authorization' do
      it 'deletes an image by id' do
        login

        delete :destroy, params: { id: @image_id }

        expect(Image.all).to be_empty
      end
    end

    context 'without authorization' do
      it 'does not delete image' do
        delete :destroy, params: { id: @image_id }

        expect(response.message).to eq 'Unauthorized'

        expect(Image.find(@image_id)).to be_truthy
      end
    end
  end
end

private

def login
  allow(AuthorizeApiRequest).to receive_message_chain(:call, :result){:user}
end

def image_stream
  return Rack::Test::UploadedFile.new(get_fixture('testshu.jpg'), 'image/jpeg')
end
