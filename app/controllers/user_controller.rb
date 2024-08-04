class UserController < ApplicationController
  def sign_in
    # Clear session on sign in page visit
    clear_session
  end

  def sign_up
    # Clear session on sign up page visit
    clear_session
  end

  def sign_in_user
    permitted_params = params.permit(:email, :password)
    user = User.find_by(email: permitted_params[:email])&.authenticate(permitted_params[:password])

    # Sets current session if user is found
    session[:current_user_id] = user.id if user

    result = {
      success: !!user
    }

    render json: { result: result }
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
