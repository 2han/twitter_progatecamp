  class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
# def create
#     @tweet = current_user.tweets.build(tweet_params)
#     if @tweet.save
#       flash[:success] = "Tweet created!"
#       redirect_to root_url
#     else
#       @feed_tweets = current_user.tweets.paginate(page: params[:page])
#       render 'about/index'
#     end
#   end
#   end
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "Tweet created!"
      redirect_to root_url
    else
      @feed_tweets = current_user.tweets.paginate(page: params[:page])
      render 'about/index'
    end
  end
  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    redirect_to root_url
  end
# アクション名がファイル名（favorites.html.erb）になる。コントローラー名がフォルダ名（tweetsフォルダ）になる
  def favorite
    # @tweetをお気に入りしているユーザーを取得
    @users = @tweet.favoriting_users.pagenate(page: params[:page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end

    def correct_user
      @tweet = Tweet.find_by(id: params[:id])
      redirect_to root_url unless current_user?(@tweet.user)
    end
end
