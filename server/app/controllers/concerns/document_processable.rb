module DocumentProcessable
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound, with: ->{render json: { error: 'Not Found' }, status: 404}
  end
end
