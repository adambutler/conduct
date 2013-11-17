class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:user][:email]) || User.create(user_params)

    respond_to do |format|
      if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        format.html { redirect_to root_url, notice: "Logged in!" }
        format.json { render :json => user }
      else
        flash.now.alert = "Uh oh... looks like your credentials aren't legit!"
        format.html { redirect_to login_path, :status => :unauthorized }
        format.json { render :json => { message: "Uh oh... looks like your credentials aren't legit!"}, :status => :unauthorized }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
