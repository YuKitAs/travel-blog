require_relative '../utils/fixture_reader'

RSpec.describe TagsController, type: 'controller' do
  before :each do
    @tags = read_fixture('tags.json')
    @tag = @tags['tag']
    @new_tag = @tags['new_tag']

    Tag.create!(@tag)
    @tag_id = Tag.find_by(name: @tag['name']).id
  end

  it 'lists all tags' do
    get :index
    tags = JSON.parse(response.body)
    tag = tags.first

    expect(response.message).to eq 'OK'

    expect(tags.size).to be 1

    expect(tag['name']).to eq @tag['name']
  end

  it 'shows a single tag by id' do
    get :show, params: { id: @tag_id }
    tag = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(tag['name']).to eq @tag['name']
  end

  it 'creates a new tag' do
    login

    post :create, params: { tag: @new_tag }
    new_tag = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(Tag.all.size). to be 2

    expect(new_tag['name']).to eq @new_tag['name']
  end

  it 'does not create tag without authorization' do
    post :create, params: { tag: @new_tag }

    expect(response.message).to eq 'Unauthorized'
  end

  it 'updates a new tag' do
    login

    put :update, params: { id: @tag_id, tag: @new_tag }
    tag = Tag.find(@tag_id)

    expect(tag['name']).to eq @new_tag['name']
  end

  it 'does not create tag without authorization' do
    put :update, params: { id: @tag_id, tag: @new_tag }

    expect(response.message).to eq 'Unauthorized'
  end

  it 'deletes an tag by id' do
    login

    delete :destroy, params: { id: @tag_id }

    expect(Tag.all).to be_empty
  end

  it 'does not create tag without authorization' do
    delete :destroy, params: { id: @tag_id }

    expect(response.message).to eq 'Unauthorized'
  end
end

private

def login
  allow(AuthorizeApiRequest).to receive_message_chain(:call, :result){:user}
end
