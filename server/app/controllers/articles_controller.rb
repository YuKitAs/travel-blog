class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render(json: @articles)
  end

  def show
    @article = Article.find(params[:article_id])
    render(json: @article)
  end
end
