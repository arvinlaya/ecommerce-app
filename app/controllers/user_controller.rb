class UserController < ApplicationController
  def sign_in
  end

  def sign_up
  end

  def create_user
    permitted_params = params.permit(:firstName, :lastName, :email, :password, :confirmPassword)

    user_data = {
      first_name: permitted_params[:firstName],
      last_name: permitted_params[:lastName],
      email: permitted_params[:email],
      password: permitted_params[:password],
      password_confirmation: permitted_params[:confirmPassword]
    }

    user = User.new(user_data)
    result = {
      success: user.save,
      errors: user.errors.full_messages
    }

    render json: { result: result }
  end
end
