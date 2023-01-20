# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors_not_found
  

  private

  def show_errors_invalid_record(exception)
    render json: { errors: "Oops, somenthing went wrong with this record: #{exception.record.errors.full_messages}" }, status: :unprocessable_entity
  end

  def show_errors_not_found(exception)
    render json: { errors: "Oops, this record does not exist" }, status: :unprocessable_entity
  end
end
