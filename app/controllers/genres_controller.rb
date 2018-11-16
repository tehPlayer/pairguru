class GenresController < ApplicationController
  def index
    @genres = Genre.all.decorate
  end

  def movies
    @genre = Genre.find(params[:id]).decorate
    @movies = @genre.movies.page(params[:page])
  end
end
