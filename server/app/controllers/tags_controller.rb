class TagsController < CrudController
  def entity_class
    return Tag
  end

  def entity_params
    params.permit(:name)
  end

  def render_entities(tags, status)
    @tags = tags
    render(:tags, status: status)
  end

  def render_entity(tag, status)
    @tag = tag
    render(:tag, status: status)
  end
end
