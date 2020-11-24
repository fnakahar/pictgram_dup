class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # CSRF対策(クロスサイトリクエストフォージェリ) : サイトに攻撃用のコードを仕込むことで、アクセスしたユーザーに対して意図しない操作を行わせる攻撃のこと。
  # 自分の日記や掲示板に意図しない書き込みがされたりといった被害を受ける可能性がある。
  protect_from_forgery with: :exception

  # Bootstrapに対応した success info warning danger 4つのキーが使用できる
  add_flash_types :success, :info, :warning, :danger

  # 以下のhelper_methodにて、2つのメソッドがapplication_helperで重複記述しなくても済むようになる
  helper_method :current_user, :logged_in?

  # a ||= xxx とするなら、aが偽か未定義であればaにXXXを代入するという自己代入演算子のこと。
  # この場合、@current_userがカラなら、session[:user_id]を@current_userに入れるという処理になる。
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # curren_userがカラではない | true ==> session[:user_id]の値が入っているのでログイン中 | false ==> カラであるという意味になるためログインユーザーがいない
  def logged_in?
    !current_user.nil?
  end
end
