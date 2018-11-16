require "rails_helper"

describe "Movies requests", type: :request, js: true do
  describe "movies list" do
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

    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "pulls and displays movie description" do
      visit "/movies"
      expect(page).to have_selector("p.movie-description", text: 'Godfather description')
    end

    it "pulls and displays movie poster" do
      visit "/movies"
      expect(page).to have_selector("img.movie-cover[src='#{api_url}/godfather.jpg']")
    end
  end
end
