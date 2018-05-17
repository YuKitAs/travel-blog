require_relative '../utils/fixture_reader'

RSpec.describe ImagesController, type: :controller do
  before :each do
    @image = Rack::Test::UploadedFile.new(get_fixture('testshu.jpg'), 'image/jpeg')
    @image_binary = BSON::Binary.new(@image.read)
    @image_id = Image.create!(content: @image_binary).to_param
  end

  describe 'GET #show' do
    it 'shows a single image by id' do
      get :show, params: { id: @image_id }

      expect(response.message).to eq 'OK'
    end
  end

  describe 'POST #create' do
    context 'with authorization' do
      it 'creates a new image with jpg format' do
        login

        post :create, params: { image: @image }

        expect(response.message).to eq 'Created'

        expect(Image.all.size). to be 2
      end

      it 'does not create image with other format' do
        login

        png_image = Rack::Test::UploadedFile.new(get_fixture('testtu.png'), 'image/png')

        post :create, params: { image: png_image }

        expect(response.message).to eq 'Bad Request'
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
