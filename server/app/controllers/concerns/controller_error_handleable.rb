module ControllerErrorHandleable
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: ->{render(status: :bad_request)}
  end
end
