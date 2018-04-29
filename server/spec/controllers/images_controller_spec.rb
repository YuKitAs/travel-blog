require_relative '../utils/fixture_reader'

RSpec.describe ImagesController, type: :controller do
  before :each do
    @image = Rack::Test::UploadedFile.new(get_fixture('testtu.png'))
    @image_binary = BSON::Binary.new(@image.read)
    @image_id = Image.create!(content: @image_binary).to_param
  end

  describe 'GET #show' do
    it 'shows a single image by id' do
      get :show, params: { id: @image_id }
      image = JSON.parse(response.body)

      expect(response.message).to eq 'OK'

      expect(Base64.decode64(image['content'])).to eq @image_binary.data
    end
  end

  describe 'POST #create' do
    context 'with authorization' do
      it 'creates a new image' do
        login

        post :create, params: { image: @image }

        expect(response.message).to eq 'Created'

        expect(Image.all.size). to be 2
      end
    end

    context 'without authorization' do
      it 'does not create image' do
        post :create, params: { image: @image }

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
