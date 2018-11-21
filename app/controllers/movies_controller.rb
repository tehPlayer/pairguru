class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info, :export]

  def index
    @movies = Movie.all.page(params[:page])
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.includes(:user)
    @comment = @movie.comments.new
    @user_commented = signed_in? && UserCommentedWarden.new(current_user, @movie).check
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoSendWorker.perform_async(current_user.id, @movie.id)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MoviesExportWorker.perform_async(current_user.id, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
