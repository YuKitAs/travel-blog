module Entity
  def representation
    representation = {}

    attribute_names.each do |attribute|
      if attribute == '_id'
        representation[:id] = self[:_id]
      else
        representation[attribute.to_sym] = self[attribute.to_sym]
      end
    end

    return representation
  end
end
