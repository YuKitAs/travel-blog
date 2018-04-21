class ArticlesController < ApplicationController
  def index
    super(Article)
  end

  def show
    super(Article)
  end

  def create
    super(Article, article_params)
  end

  def update
    super(Article, article_params)
  end

  def destroy
    super(Article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :date, :place_id)
  end
end
