class UsersController < ApplicationController
  #ターミナルでrails g controller usersでディレクトリ作成
  def show
    # 下のままだと投稿者の名前を選択しても自分のマイページに飛んでしまうためcurrent_userを使ったままではだめ
    #currnet 意味　現在
    # @nickname = current_user.nickname
    # @tweets = current_user.tweets
    # コメント欄に表示されるユーザー名をクリックすることで送られたidをparamsで取得して、そのユーザーのレコードを変数userに代入しています。それから、各インスタンス変数ではcurrent_userを変数userに変えています。その上で、@nicknameでは、ユーザーのnicknameを取り出しています。アソシエーションを利用しuser.tweetsとすることで、そのユーザーが投稿したツイートを取得して、@tweetsに代入しています。
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
end
