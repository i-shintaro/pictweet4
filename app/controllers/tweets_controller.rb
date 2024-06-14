class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.all
  end
    #生成のアクション
  def new
    #newメソッドを利用してTweetモデルのインスタンスを生成してインスタンス変数に代入
    #new.html.erbでインスタンス変数として利用できる
    @tweet = Tweet.new
  end
#保存のアクション
  def create
    # Tweetモデルにcreateメソッドを利用して保存される
    Tweet.create(tweet_params)
    # 保存されたらルートパス（indexアクション）に遷移する
    redirect_to '/'
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to root_path
  end

  def show
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end

  # privateメソッドを定義し外部から呼び出されないようにする
  private
  # tweet_paramsといったインスタンスメソッドを作成しメソッドの中身は
  # form_withから入力されてきた属性値をparamsに格納する
  # その際にストロングパラメーターを利用してモデルと属性（DBのカラム）を指定している
  def tweet_params
    params.require(:tweet).permit(:name, :image, :text)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end

