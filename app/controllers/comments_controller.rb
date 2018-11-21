class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie

  def create
    @comment = @movie.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @movie, notice: 'Comment added.'
    else
      @comments = @movie.comments.includes(:user)
      @user_commented = UserCommentedWarden.new(current_user, @movie).check
      flash[:alert] = @comment.errors.full_messages.join
      render 'movies/show'
    end
  end

  protected

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
