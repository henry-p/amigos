class HomeController < ApplicationController
  def index
    redirect_to user_index_path if logged_in?
  end
end
