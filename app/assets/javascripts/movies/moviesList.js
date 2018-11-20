//= require ./movie
//= require ./moviesBase

class MoviesList extends MoviesBase {
  constructor(node) {
    super();
    this.moviesData = {};
    this.movieNodes = _.map(
      node.querySelectorAll('.movie'),
      (movieNode) => {return new Movie(movieNode)}
    )
  }

  getMoviesInfo() {
    this.findTitles();
    this.updateMoviesData();
  };

  findTitles() {
    let movieTitles = this.movieNodes.map(movie => {return movie.title});
    this.movieTitles = _.uniq(movieTitles);
  };

  updateMoviesData() {
    this.movieTitles.map((title) => { this.executeUpdate(title); });
  };

  updateView(movieData) {
    this.movieNodes.forEach((node) => {
      if (node.title !== movieData.title) { return }
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
    let movies = new MoviesList(moviesSelector);
    movies.getMoviesInfo();
  };
});