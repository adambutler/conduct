class PasswordResetsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    user = User.find_by_email(email)

    if user.present?
      user.send_password_reset
      redirect_to login_path, :notice => "Check your inbox"
    else
      flash[:alert] = "Sorry we don't have a user with that e-mail."
      render :new
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.update_attributes(user_params)
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end

