class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in if you want access to Coco Bongo Club"
      redirect_to login_path
    end
  end
end
