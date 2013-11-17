module ApplicationHelper

  def get_theme
    return "theme theme--orange" if params[:controller] == "static" and  params[:action] == "landing"
  end

end
