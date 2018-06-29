class AuthenticationController < ApplicationController
  def login
    unless User.find_by(username: params[:username]).authenticate(params[:password])
      raise(AuthenticationFailedError)
    end

    @jwt = JwtService.encode(username: params[:username])

    render(:jwt, status: :ok)
  rescue Mongoid::Errors::DocumentNotFound
    raise(AuthenticationFailedError)
  end
end
