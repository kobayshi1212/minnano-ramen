class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if@post.save
      redirect_to root_path, notice: '投稿が保存されました。'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
     flash[:notice] = "投稿の編集が保存されました。"
     redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to mypage_path, notice: '投稿を削除しました。'
    else
      flash.now[:alert] = '投稿の削除に失敗しました。'
      render :show
    end
  end


  private

  def post_params
    params.require(:post).permit(:store, :menu, :impressions, :address, :image)
  end
end
