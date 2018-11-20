//= require ./movie

class Movies {
  constructor(node) {
    this.base = node;
    this.moviesData = {};
    this.movieNodes = _.map(
      node.querySelectorAll('.movie'),
      (movieNode) => {return new Movie(movieNode)}
    )
  }

  getMoviesInfo() {
    this._findTitles();
    this._pullAndUpdateData();
  };

  _findTitles() {
    let movieTitles = this.movieNodes.map(movie => {return movie.title});
    this.movieTitles = _.uniq(movieTitles);
  };

  _pullAndUpdateData() {
    this.movieTitles.map((title) => {
      axios.get("api/v1/movies/" + title)
        .then((response) => {
          let attributes = response.data['data']['attributes'];
          let movieData = {
            ...attributes,
            poster: axios.defaults.apiURL + attributes['poster']
          };
          this._updateTable(title, movieData);
        })
        .catch((error) => {
          let errorData = {
            plot: 'Error fetching: ' + title
          };
          this._updateTable(title, errorData);
        });
    });
  };

  _updateTable(title, movieData) {
    this.movieNodes.forEach((node) => {
      if (node.title !== title) { return }
      let attributes = movieData;
      node.setPlot(attributes['plot']);
      node.setPoster(attributes['poster']);
      node.setRating(attributes['rating']);
    });
  }
};

document.addEventListener("DOMContentLoaded", function(event) { 
  let moviesSelector = document.querySelector('#movies');
  if (moviesSelector) {
    let movies = new Movies(moviesSelector);
    movies.getMoviesInfo();
  };
});