class TweetsController < ApplicationController
  def index
    @tweets=Tweet.page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet=Tweet.new
  end

  def create
    tweet=Tweet.new(tweet_params)
    tweet.save
    redirect_to root_path
  end


private
  def tweet_params
    params.require(:tweet).permit(:content,)
  end
end
