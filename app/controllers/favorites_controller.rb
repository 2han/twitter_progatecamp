def favorite
    @title = 'Favorite Tweets'
    @tweet = current_user.tweets.build
    @feed_tweets = current_user.favorite_tweets.paginate(page: params[:page])
    render 'about/index'
  end