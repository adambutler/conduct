class StaticController < ApplicationController
  def landing
    render "static/landing/landing"
  end

  def api
    render "static/api/api"
  end
end
