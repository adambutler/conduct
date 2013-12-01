class AccessTokenController < ApplicationController

  def new
    current_user.access_token_reset
    redirect_to account_edit_path, :notice => "User updated"
  end

end

