class ArticlesController < CrudController
  DEFAULT_ARTICLES_LIMIT = 50

  def show_featured_preview
    featured_article_id = SiteConfiguration.find_by(key: 'featured_article_id').value
    raw_article = Article.find(featured_article_id)
    @article = raw_article.with_related_fields(*related_fields(raw_article))

    render(:article_preview, status: :ok)
  end

  def update_featured
    AuthenticationService.authenticate(request.headers)

    featured_article_id = params[:id]
    unless /\A[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\z/.match?(featured_article_id)
      raise(InvalidDataError, 'Id has incorrect format.')
    end
    SiteConfiguration.find_or_create_by(key: 'featured_article_id').update(value: featured_article_id)

    @article = Article.find(featured_article_id)

    render(:article, status: :ok)
  end

  def index_preview
    all_filters = {}
    if params[:tag_ids]
      all_filters[:tag_ids] = params[:tag_ids]
    end
    search_criteria = Article.all(all_filters).order_by(:date.desc, :created_at.desc)
    search_criteria = search_criteria.skip(params[:start].to_i) if params[:start]
    search_criteria = if params[:limit] && params[:limit] <= DEFAULT_ARTICLES_LIMIT
                        search_criteria.limit(params[:limit].to_i)
                      else
                        search_criteria.limit(DEFAULT_ARTICLES_LIMIT)
                      end

    @articles = search_criteria.to_a.map{|article| article.with_related_fields(*related_fields(article))}

    render(:articles_preview, status: :ok)
  end

  def show_full
    raw_article = Article.find(params[:id])
    @article = raw_article.with_related_fields(*related_fields(raw_article))

    render(:article_full, status: :ok)
  end

  def entity_class
    return Article
  end

  def entity_params
    return params.permit(:title, :date, :introduction, :content, :place_id, :thumbnail_id, tag_ids: [])
  end

  def render_entities(articles, status)
    @articles = articles
    render(:articles, status: status)
  end

  def render_entity(article, status)
    @article = article
    render(:article, status: status)
  end

  private

  def related_fields(article)
    return [
      Place.where(id: article.place_id).first,
      article.tag_ids.map{|tag_id| Tag.where(id: tag_id).first}.reject(&:nil?),
      Image.where(id: article.thumbnail_id).first&.thumbnail
    ]
  end
end
