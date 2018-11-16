require "rails_helper"

describe Api::V2::MoviesController, type: :controller do
  describe "#index" do
    let(:movies) { create_list(:movie, 5) }

    let(:expected_response) do
      movies.map do |movie|
        genre = movie.genre
        {
          "id" => movie.id,
          "title" => movie.title,
          "genre" => {
            "id" => genre.id,
            "name" => genre.name,
            "movies_count" => genre.movies.count
          }
        }
      end
    end

    it "returns an array of movies with id, title and genre object" do
      get :index
      expect(response).to eq(expected_response)
    end
  end
end