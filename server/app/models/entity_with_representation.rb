module EntityWithRepresentation
  def representation
    representation = {}

    attribute_names.each do |attribute_name|
      if attribute_name == '_id'
        representation[:id] = self[:_id]
      else
        representation[attribute_name.to_sym] = self[attribute_name.to_sym]
      end
    end

    return representation
  end
end
