class ArticlesController < ApplicationController
  skip_before_action :authenticate_request, except: [:create, :update, :destroy, :update_featured]

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

  def index_preview
    start = params[:start].to_i || 0
    limit = params[:limit].to_i || (Article.count + 1)

    article_previews = Article
      .order_by(:date.desc, :_id.asc).skip(start).limit(limit).to_a
      .map{|article| article_preview_of(article)}

    render(json: article_previews)
  end

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

  def article_preview_of(article)
    image = Image.find(article[:thumbnail_id])
    thumbnail = image[:thumbnail]
    place = Place.find(article[:place_id])

    return {
      id: article[:_id],
      thumbnail: {
        id: image[:_id],
        width: thumbnail[:width],
        height: thumbnail[:height]
      },
      title: article[:title],
      date: article[:date],
      place: {
        id: place[:_id],
        name: place[:name]
      },
      introduction: article[:introduction]
    }
  end
end
