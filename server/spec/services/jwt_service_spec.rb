RSpec.describe JwtService do
  it 'encodes the data and also decodes it' do
    data = 'some random string'
    key = 'some random key'
    encrypted_data = JwtService.encode({ data: data }, key)
    decrypted_data = JwtService.decode(encrypted_data, key)

    expect(decrypted_data[:data]).to eq data
  end
end
