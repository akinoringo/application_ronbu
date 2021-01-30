class ToppagesController < ApplicationController
  def index
    if logged_in?
      @paper = current_user.papers.build #form_with用
      @papers = current_user.papers.search(params[:search]).order(id: :desc).page(params[:page]).per(10)
    else
      @user = User.new
    end
  end
  


end
