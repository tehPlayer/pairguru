// CORS are set incorrectly on the server, using workaround
axios.defaults.apiURL = 'https://pairguru-api.herokuapp.com'
axios.defaults.baseURL = 'https://cors-anywhere.herokuapp.com/' + axios.defaults.apiURL;
axios.defaults.headers.common['X-Requested-With'] = 'localhost:3000';
