require "rails_helper"

describe "Movies requests", type: :request, js: true do
  let(:movie) { create(:movie, title: 'Godfather') }
  let(:api_response) do
    {
      data: {
        id: "6",
        type: "movie",
        attributes: {
          title: "Godfather",
          plot: "Godfather description",
          rating: 9.2,
          poster: "/godfather.jpg"
        }
      }
    }
  end
  let(:api_url) { 'https://pairguru-api.herokuapp.com' }

  before do
    cors_anywhere_url = 'https://cors-anywhere.herokuapp.com:443'
    endpoint = "api/v1/movies/#{movie.title}"
    proxy.stub([cors_anywhere_url, api_url, endpoint].join('/')).and_return(
      headers: { 'Access-Control-Allow-Origin' => '*' },
      json: api_response
    )
  end

  describe "movies list" do
    before do
      visit "/movies"
    end

    it "displays right title" do
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "pulls and displays movie rating" do
      expect(page).to have_selector(".movie-rating", text: '9.2')
    end

    it "pulls and displays movie description" do
      expect(page).to have_selector("p.movie-description", text: 'Godfather description')
    end

    it "pulls and displays movie poster" do
      expect(page).to have_selector("img.movie-cover[src='#{api_url}/godfather.jpg']")
    end
  end

  describe "movie details" do
    before do
      visit "/movies/#{movie.id}"
    end

    it "pulls and displays movie rating" do
      expect(page).to have_selector(".movie-rating", text: '9.2')
    end

    it "pulls and displays movie description" do
      expect(page).to have_selector(".movie-description", text: 'Godfather description')
    end

    it "pulls and displays movie poster" do
      expect(page).to have_selector("img.movie-cover[src='#{api_url}/godfather.jpg']")
    end
  end
end
