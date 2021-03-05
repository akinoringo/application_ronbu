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

  def show
    @paper = Paper.find_by(id: params[:id])
  end

  def edit
    @paper = Paper.find_by(id: params[:id])
  end

  def update
    @paper = Paper.find_by(id: params[:id])
    if @paper.update(paper_params)
      flash[:success] = "論文は正常に更新されました。"
      redirect_to @paper
    else
      flash.now[:danger] = "論文は正常に更新されませんでした。"
      render :edit
    end
  end

  def destroy
    @paper = Paper.find_by(id: params[:id])
    @paper.destroy
    flash[:success] = "論文を削除しました"
    redirect_to root_url
  end

  def download

    @paper = Paper.find_by(id: params[:id])

    region = "us-east-1"
    bucket = "ronbu-storage"
    key = @paper.pdf.filename
    s3_client = Aws::S3::Client.new(region: region)

    data = client.get_object(bucket: bucket, key: key).body
    send_data(data, filename: download.pdf)

  end  

  private

  def paper_params
    params.require(:paper).permit(:title, :tag, :content, :pdf)
  end

  def correct_user
    @paper = current_user.papers.find_by(id: params[:id])
    unless @paper
      redirect_to root_url
    end
  end
end
