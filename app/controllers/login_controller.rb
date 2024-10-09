class LoginController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to login_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to dashboard_url
    else
      redirect_to login_url, alert: "Invalid email or password."
    end
  end

  def destroy
    terminate_session
    redirect_to home_url
  end
end
