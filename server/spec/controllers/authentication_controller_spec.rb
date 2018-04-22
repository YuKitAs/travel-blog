RSpec.describe AuthenticationController, type: :controller do
  before :each do
    @username = 'test_user'
    @password = 'correct_password'
    @user = User.create!(username: @username, password: @password)
  end

  it 'logs in user with correct credentials' do
    post :login, params: { username: @username, password: @password }

    expect(response.message).to eq 'OK'
    expect(response.body).to include('auth_token')
  end

  it 'returns error on non-existing user' do
    post :login, params: { username: 'nouser@email.com', password: 'nopassword' }

    expect(response.message).to eq 'Not Found'
  end

  it 'returns error on incorrect credentials' do
    post :login, params: { username: @username, password: 'fake_password' }

    expect(response.message).to eq 'Unauthorized'
  end
end
