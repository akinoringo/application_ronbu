class ToppagesController < ApplicationController
  def index
    if logged_in?
      @paper = current_user.papers.build #form_with用
      @papers = current_user.papers.order(id: :desc).page(params[:page]).per(10)
    end
  end
end
