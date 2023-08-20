class HomeController < ApplicationController

  before_action :forbid_login_user,{only:[:top]}

  def top
  end

  def about
    render json: { message: 'Welcome to the about page!' }
  end
end
