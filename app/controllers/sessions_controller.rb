class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインに成功しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render :new
    end
  end

  def guestlogin
    if glogin
      flash[:success] = "ログインに成功しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render :new
    end
  end  

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end

  def glogin
    @user = User.find_or_create_by!(email: "guest@akinori.com")
    @user.password = SecureRandom.urlsafe_base64
    if @user && @user.authenticate(@user.password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end


end
