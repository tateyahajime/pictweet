class TweetsController < ApplicationController
  #before_action 全てのアクションを実行する前に指定したメソッドを呼び出す　同じコードの場合defの中身を無くしてprivateの中にset_tweetに記述する
  before_action :set_tweet,only: [:edit, :show]
  #未ログインユーザーが投稿画面など直接アクセスしてきた際にはルートパスに遷移するように設定を行います。これを実現するために、tweets_controller.rbの全てのアクションに対して、「もし、ユーザーがログインしていなかったらindexアクションにリダイレクトする」 を実装します。
  before_action :move_to_index, except: [:index, :show]
  
  def index
    
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
    # 下のコードが入ってるprivateのset_tweetに一緒にしてある
    # @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    # 下のコードが入ってるprivateのset_tweetに一緒にしてある
    # @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end
  
  private
  def tweet_params
    #ツイート保存時にユーザー情報を追加する処理をする前のコード
    # params.require(:tweet).permit(:name, :image, :text)

    #ツイート保存時にユーザー情報を追加する処理をする
    # permitのところに:nameも入っていたが投稿時に「name」を入力する必要がなくなったので、それに合わせてtweetsコントローラーの処理も変更
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)

  end
# before_actionとセット　一緒のコードをまとめることができる
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end