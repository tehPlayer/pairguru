//= require ./movie
//= require ./moviesBase

class MovieShow extends MoviesBase {
  constructor(node) {
    super();
    this.movie = new Movie(node)
  }

  getMovieInfo() {
    let title = this.movie.getTitle()
    this.executeUpdate(title)
  }

  updateView(movieData) {
    this.movie.setPlot(movieData['plot']);
    this.movie.setPoster(movieData['poster']);
    this.movie.setRating(movieData['rating']);
  }
}

document.addEventListener("DOMContentLoaded", function(event) { 
  let movieSelector = document.querySelector('#movie');
  if (movieSelector) {
    let movieNode = new MovieShow(movieSelector);
    movieNode.getMovieInfo();
  };
});