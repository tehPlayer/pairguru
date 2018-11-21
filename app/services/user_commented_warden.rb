class UserCommentedWarden
  attr_reader :user, :movie

  def initialize(user, movie)
    @user, @movie = user, movie
  end

  def check
    user.comments.pluck(:movie_id).include?(movie.id)
  end
end