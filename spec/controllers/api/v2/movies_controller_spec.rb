require "rails_helper"

describe Api::V2::MoviesController, type: :controller do
  describe "#index" do
    let(:movies) { create_list(:movie, 5) }

    let(:response) do
      movies.map do |movie|
        genre = movie.genre
        {
          id: movie.id,
          title: movie.title,
          genre: {
            genre.id,
            genre.name,
            genre.movies.count
          }
        }
      end
    end

    it "returns an array of movies with id, title and genre object" do
      get :index
      expect(response).to eq(response)
    end
  end
end