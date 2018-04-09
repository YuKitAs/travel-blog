require 'securerandom'

class ArticlesController < ApplicationController
  def index
    @documents = Article.all
    @articles = []
    @documents.each do |doc|
      @articles.push(convert_to_article(doc))
    end
    render(json: @articles)
  end

  def show
    @document = Article.find(params[:id])
    render(json: convert_to_article(@document))
  end

  def create
    @document = Article.new(article_params.merge(_id: SecureRandom.uuid))
    @document.save
    render(json: convert_to_article(@document))
  end

  def update
    @document = Article.find(params[:id])
    @document.update(article_params)
  end

  def destroy
    @document = Article.find(params[:id])
    @document.destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def convert_to_article(document)
    return { id: document[:_id], title: document[:title], content: document[:content], date: document[:date] }
  end
end
