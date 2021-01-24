class ApplicationController < ActionController::Base
  
  include SessionsHelper

  private

  def requre_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_papers = user.papers.count
  end
end
