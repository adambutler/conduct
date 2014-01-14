class SessionsController < ApplicationController
  def create

    user = get_user

    respond_to do |format|
      if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        format.html { redirect_to topics_path }
        format.json { render :json => user }
      else
        flash.now.alert = "Uh oh... looks like your credentials aren't legit!"
        format.html { redirect_to login_path, :notice => "Invalid login" }
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
    params.require(:user).permit(:email, :password)
  end

  def get_user

    user = User.find_by_email(params[:user][:email])

    if user.present?
      return user
    else
      return User.create(user_params)
    end

  end

end
