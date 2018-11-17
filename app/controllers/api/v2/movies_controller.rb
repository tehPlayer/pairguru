module Api
  module V2
    class MoviesController < Api::ApplicationController
      def index
        @movies = Movie.eager_load(:genre).
                        released

        render json: @movies, each_serializer: MovieSerializer
      end
    end
  end
end
