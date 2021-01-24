class PapersController < ApplicationController
  before_action :requre_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @paper = current_user.papers.build(paper_params)
    if @paper.save
      flash[:success] = "論文を投稿しました。"
      redirect_to root_url
    else
      @papers = current_user.papers.order(id: :desc).page(params[:page])
      flash.now[:danger] = "論文の投稿に失敗しました。"
      render "toppages/index"
    end
  
  end

  def destroy
    @paper.destroy
    flash[:success] = "論文を削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def paper_params
    params.require(:paper).permit(:content)
  end

  def correct_user
    @paper = current_user.papers.find_by(id: params[:id])
    unless @paper
      redirect_to root_url
    end
  end
end
