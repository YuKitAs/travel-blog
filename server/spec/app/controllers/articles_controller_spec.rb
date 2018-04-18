require_relative '../../utils/fixture_reader'
require 'controllers/articles_controller'
require 'json'

RSpec.describe ArticlesController, type: 'controller' do
  before :each do
    @articles = read_fixture('articles.json')

    Article.with_session(casual_consistency: true) do
      Article.delete_all
      Article.create(@articles)
    end
  end

  it 'lists all articles' do
    get :index
    articles = JSON.parse(response.body)
    article = articles.first

    expect(response.message).to eq 'OK'

    expect(articles.size).to be 1

    expect(article['id']).to eq @articles['id']
    expect(article['title']).to eq @articles['title']
    expect(article['content']).to eq @articles['content']
    expect(article['date']).to eq @articles['date']
  end

  it 'shows a single article by id' do
    get :show, params: { id: @articles['id'] }
    article = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(article['title']).to eq @articles['title']
    expect(article['content']).to eq @articles['content']
    expect(article['date']).to eq @articles['date']
  end
end
