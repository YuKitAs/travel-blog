class ArticlesController < ApplicationController
  def index
    if params[:tag_id].nil?
      super
    else
      article_representations = []
      Article.all.each do |article|
        article_representations.push(article.representation) if article[:tag_ids].include?(params[:tag_id])
      end

      render(json: article_representations)
    end
  end

  private

  def entity
    return Article
  end

  def entity_field_params
    return params.require(:article).permit(:title, :content, :date, :place_id, :thumbnail_id, tag_ids: [])
  end
end
