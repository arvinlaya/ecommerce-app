class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :current_user

  def current_user
    @user = User.find(session[:current_user_id]) if session[:current_user_id]
  end

  def require_sign_in
    unless session[:current_user_id]
      redirect_to sign_in_path
    end
  end

  def clear_session
    session.clear
  end
end
