class MoviesBase {
  executeUpdate(title) {
    axios.get("api/v1/movies/" + title)
      .then(response => this.responseHandler(response))
      .catch(error => this.errorHandler(error, title))
  };

  responseHandler(response) {
    let attributes = response.data['data']['attributes'];
    let movieData = {
      ...attributes,
      poster: axios.defaults.apiURL + attributes['poster']
    };
    this.updateView(movieData);
  };

  errorHandler(error, title) {
    let errorData = {
      title: title,
      plot: 'Error fetching: ' + title
    };
    this.updateView(errorData);
  };

  updateView(data) {
    throw('Abstract method called: updateView');
  };
};