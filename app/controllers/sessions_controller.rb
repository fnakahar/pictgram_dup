class SessionsController < ApplicationController
  def new
  end

  def create
    # sessions#newで入力されたメールアドレスを持つユーザーがいるかどうかをチェックしている。該当ありならuserへ代入する。
    user = User.find_by(email: session_params[:email])
    # メールアドレスを持つユーザーが存在し、且つ、入力されたパスワードがレコードに格納されているパスワードと合致している場合に限り、ログインさせる
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private
  # ここでやりたいことは、session[:user_id]に、ログインしてきたユーザのuser.idをレコードからコピーしておく。これがcurrent_user_idになるから
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end


end
