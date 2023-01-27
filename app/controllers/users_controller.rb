# frozen_string_literal: true

class UsersController < ApplicationController
  def auth
    
    binding.break
    
    user = User.find_by(user_name: params[:user_name])
    if user&.authenticate(params[:password])
      token = encode({ user_id: user.id })
      render json: { user:, token: }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:user_name, :password)
  end
end
