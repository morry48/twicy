class TweetsController < ApplicationController

before_action :move_to_index, except: :index

  def index
    @tweets=Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet=Tweet.new
  end

  def create
    tweet=Tweet.create(name: tweet_params[:name],image: tweet_params[:image], content: tweet_params[:content],user_id: current_user.id)
    tweet.save
    redirect_to root_path
  end


private
  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def tweet_params
    params.permit(:content, :name)
  end
end
