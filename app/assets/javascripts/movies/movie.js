class Movie {
  constructor(node) {
    this.node = node;
    this.title = this.getTitle();
  }

  getTitle() {
    return this.node.querySelector('.movie-title').textContent;
  }

  setPlot(newPlot) {
    this.node.querySelector('.movie-description').textContent = newPlot;
    return true;
  }

  setPoster(newPost) {
    this.node.querySelector('.movie-cover').setAttribute('src', newPost);
    return true;
  }
}