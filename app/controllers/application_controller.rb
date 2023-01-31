# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors_not_found

  def encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def decode
    auth_header = request.headers['Authorization']
    return unless auth_header

    token = auth_header.split(' ').last
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def authorized_user
    decoded_token = decode
    return unless decode

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def authorize
    render json: { message: 'You need be logged!' }, status: :unauthorized unless authorized_user
  end

  private

  def show_errors_invalid_record(exception)
    render json: { errors: "Oops.. #{exception.record.errors.full_messages}" },
           status: :unprocessable_entity
  end

  def show_errors_not_found(_exception)
    render json: { errors: 'Oops, this record does not exist' }, status: :unprocessable_entity
  end
end
