class TweetsController < ApplicationController

before_action :move_to_index, except: :index

  def index
    @tweets=Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet=Tweet.new
  end

  def create
    @tweet=Tweet.new(tweet_params)
    @tweet.save
    redirect_to root_path
  end

  def show
    @tweet=Tweet.find(params[:id])
  end



private
  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def tweet_params
    params.require(:tweet).permit(:content, :name).merge( user_id: current_user.id)
  end
end
