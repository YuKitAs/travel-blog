require_relative '../utils/fixture_reader'
require 'controllers/articles_controller'
require 'json'

RSpec.describe ArticlesController, type: 'controller' do
  before :each do
    @articles = read_fixture('articles.json')
    @article = @articles['article']
    @new_article = @articles['new_article']

    Article.create!(@article)
    @article_id = Article.find_by(title: @article['title']).id
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
  end

  it 'shows a single article by id' do
    get :show, params: { id: @article_id }
    article = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(article['title']).to eq @article['title']
    expect(article['content']).to eq @article['content']
    expect(article['date']).to eq @article['date']
    expect(article['place_id']).to eq @article['place_id']
  end

  it 'creates a new article' do
    post :create, params: { article: @new_article }
    new_article = JSON.parse(response.body)

    expect(response.message).to eq 'OK'

    expect(Article.all.size). to be 2

    expect(new_article['title']).to eq @new_article['title']
    expect(new_article['content']).to eq @new_article['content']
    expect(new_article['date']).to eq @new_article['date']
    expect(new_article['place_id']).to eq @new_article['place_id']
  end

  it 'updates a new article' do
    put :update, params: { id: @article_id, article: @new_article }
    article = Article.find(@article_id)

    expect(article['title']).to eq @new_article['title']
    expect(article['content']).to eq @new_article['content']
    expect(article['date']).to eq @new_article['date']
    expect(article['place_id']).to eq @new_article['place_id']
  end

  it 'deletes an article by id' do
    delete :destroy, params: { id: @article_id }

    expect(Article.all).to be_empty
  end
end
