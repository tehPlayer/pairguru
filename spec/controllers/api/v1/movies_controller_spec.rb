require "rails_helper"

describe Api::V1::MoviesController, type: :controller do
  describe "#index" do
    let(:movies) { create_list(:movie, 5) }

    let(:response) do
      movies.map do |movie|
        {id: movie.id, title: movie.title}
      end
    end

    it "returns an array of movies with id and title only" do
      get :index
      expect(response).to eq(response)
    end
  end
end