module ApplicationHelper

  def get_theme
    return "theme theme--orange" if params[:controller] == "static" and  params[:action] == "landing"
  end

  def generate_token(length)
    return rand(36**length).to_s(36)
  end

end
