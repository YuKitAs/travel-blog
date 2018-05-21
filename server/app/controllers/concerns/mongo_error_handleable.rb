module MongoErrorHandleable
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound, with: ->{render(status: :not_found)}
    rescue_from Mongoid::Errors::Validations, with: ->{render(status: :bad_request)}
  end
end
