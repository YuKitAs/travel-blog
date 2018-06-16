class ArticlesController < ApplicationController
  skip_before_action :authenticate_request, except: [:create, :update, :destroy, :update_featured]

  def show_featured
    featured_article_id = SiteConfiguration.find_by(key: 'featured_article_id').value

    render(json: article_preview_of(Article.find(featured_article_id)))
  end

  def update_featured
    SiteConfiguration.find_or_create_by(key: 'featured_article_id').update(value: params[:id])
  end

  private

  def entity
    return Article
  end

  def entity_field_params
    return params.require(:article).permit(:title, :introduction, :content, :date,
      :place_id, :thumbnail_id, tag_ids: [])
  end
end
