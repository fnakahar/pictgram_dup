class TopicsController < ApplicationController
  def new
    if logged_in?
      @topic = Topic.new
    else
      redirect_to login_path, danger: 'ログインしてください'
    end
  end

  def create
    # current_userからログイン中のuser_idを取得し、topics.newからimageとdescriptionを取得する。それを@topic(モデル)に入れる。
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def index
    if logged_in?
      # Topic.allでTopicモデル内の全投稿とそれぞれの投稿に誰がいいねをしているかのfavorite_usersの情報をキャッシュし、@topicsへ代入にしている
      @topics = Topic.all.includes(:favorite_users)
    else
      redirect_to login_path, danger: 'ログインしてください'
    end
  end


  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end
