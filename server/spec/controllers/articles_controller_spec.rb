require_relative '../utils/fixture_reader'

RSpec.describe ArticlesController, type: 'controller' do
  before :each do
    @articles = read_fixture('articles.json')
    @article = @articles['article']
    @new_article = @articles['new_article']

    @article_id = Article.create!(@article).to_param
  end

  it 'lists all articles' do
    get :index
    articles = JSON.parse(response.body)
    article = articles.first

    expect(response.message).to eq 'OK'

    expect(articles.size).to be 1

    expect(article['title']).to eq @article['title']
    expect(article['content']).to eq @article['content']
    expect(article['date']).to eq @article['date']
    expect(article['place_id']).to eq @article['place_id']
    expect(article['tag_ids']).to eq @article['tag_ids']
  end

  it 'shows a single article by id' do
    get :show, params: { id: @article_id }
    article = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(article['title']).to eq @article['title']
    expect(article['content']).to eq @article['content']
    expect(article['date']).to eq @article['date']
    expect(article['place_id']).to eq @article['place_id']
    expect(article['tag_ids']).to eq @article['tag_ids']
  end

  it 'creates a new article' do
    login

    post :create, params: { article: @new_article }
    new_article = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(Article.all.size). to be 2

    expect(new_article['title']).to eq @new_article['title']
    expect(new_article['content']).to eq @new_article['content']
    expect(new_article['date']).to eq @new_article['date']
    expect(new_article['place_id']).to eq @new_article['place_id']
    expect(new_article['tag_ids']).to eq @new_article['tag_ids']
  end

  it 'does not create article without authorization' do
    post :create, params: { article: @new_article }

    expect(response.message).to eq 'Unauthorized'
  end

  it 'updates a new article' do
    login

    put :update, params: { id: @article_id, article: @new_article }
    article = Article.find(@article_id)

    expect(article['title']).to eq @new_article['title']
    expect(article['content']).to eq @new_article['content']
    expect(article['date']).to eq @new_article['date']
    expect(article['place_id']).to eq @new_article['place_id']
    expect(article['tag_ids']).to eq @new_article['tag_ids']
  end

  it 'does not create article without authorization' do
    put :update, params: { id: @article_id, article: @new_article }

    expect(response.message).to eq 'Unauthorized'
  end

  it 'deletes an article by id' do
    login

    delete :destroy, params: { id: @article_id }

    expect(Article.all).to be_empty
  end

  it 'does not create article without authorization' do
    delete :destroy, params: { id: @article_id }

    expect(response.message).to eq 'Unauthorized'
  end
end

private

def login
  allow(AuthorizeApiRequest).to receive_message_chain(:call, :result){:user}
end
