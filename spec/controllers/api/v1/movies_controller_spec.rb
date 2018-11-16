require "rails_helper"

describe Api::V1::MoviesController, type: :controller do
  describe "#index" do
    let(:movie1) { create(:movie) }
    let(:movie2) { create(:movie) }

    let(:response) do
      [
        {id: movie1.id, title: movie1.title},
        {id: movie2.id, title: movie2.title}
      ]
    end

    it "returns an array of movies with id and title only" do
      get :index
      expect(response).to eq(response)
    end
  end
end