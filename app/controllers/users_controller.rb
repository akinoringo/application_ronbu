class UsersController < ApplicationController
  before_action :requre_user_logged_in, only: [:index, :show, :edit]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find_by(id: params[:id])
    @papers = @user.papers.order(id: :desc).page(params[:page]).per(10)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "ユーザーを登録しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました"
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールは正常に更新されました。"
      redirect_to @user
    else
      flash.now[:danger] = "プロフィールは正常に更新されませんでした。"
      render :edit
    end
  end

  def download
    @user = User.find_by(id: params[:id])
    data = @user.image.download
    send_data(data, type: "image/png", filename: "download.jpg")
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
