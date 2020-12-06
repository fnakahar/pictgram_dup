class CommentsController < ApplicationController
  def new
    # binding.pry
    if logged_in?
      # コントローラーで＠をつけた変数がビューで使える
      @topic = Topic.find(params[:topic_id])
      @comment = @topic.comments.new
    else
      redirect_to login_path, danger: 'ログインしてください'
    end
  end
  def create
    comment = current_user.comments.new(comment_params)
    #binding.pry
    if comment.save
      redirect_to topics_path, success: 'コメントを投稿しました'
    else
      redirect_to topics_path, danger: 'コメントの投稿に失敗しました'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :topic_id, :description)
  end

end