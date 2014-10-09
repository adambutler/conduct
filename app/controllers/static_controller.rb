class StaticController < ApplicationController

  before_filter :redirect_if_logged_in, only: [:landing]
  
  def landing
    render "static/landing/landing"
  end

  def api
    render "static/api/api"
  end

  private

  def redirect_if_logged_in
    if current_user
      redirect_to(topics_path)
    end
  end

end
