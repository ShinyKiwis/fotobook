class PasswordResetsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    end
  end

  def reset
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:alert] = 'No user exists with that email!'
      redirect_to password_reset_path
    else
      user.send_reset_password_instructions
      flash[:notice] = 'Please check your mail for instruction'
    end
  end
end
