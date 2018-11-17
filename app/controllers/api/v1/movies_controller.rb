module Api
  module V1
    class MoviesController < Api::ApplicationController
      def index
        @movies = Movie.select(:id, :title).released
        render json: @movies, each_serializer: MovieSerializer
      end
    end
  end
end
