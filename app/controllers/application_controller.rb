class ApplicationController < ActionController::API
  # protect_from_forgery

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:secret_key_base])
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]
      begin
        JWT.decode(token, Rails.application.credentials[:secret_key_base])
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
