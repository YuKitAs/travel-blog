RSpec.describe JwtService do
  it 'encodes the data and also decodes it' do
    data = 'some random string'
    encrypted_data = JwtService.encode(data: data)
    decrypted_data = JwtService.decode(encrypted_data)

    expect(decrypted_data[:data]).to eq data
  end
end
