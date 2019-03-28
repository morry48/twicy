class TweetsController < ApplicationController

before_action :move_to_index, except: :index

  def index
    @tweets=Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet=Tweet.new
  end

  def create
    Tweet.create(content: tweet_params[:content],user_id: current_user.id)
    redirect_to root_path , notice: 'ツイートを作成しました'
  end

  def show
    @tweet=Tweet.find(params[:id])
  end

  def edit
    @tweet=Tweet.find_by(id: params[:id])
  end

  def update
    tweet = Tweet.find_by(id: params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)
    end
    redirect_to user_path , notice: 'ツイートを編集しました'
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
    redirect_to user_path, notice: 'ツイートを削除しました'
  end



private
  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def tweet_params
    params.require(:tweet).permit(:content,).merge(user_id: current_user.id)
  end

end
