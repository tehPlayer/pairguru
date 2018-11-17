desc "Recalculates movies counter cache for genres"
task set_movies_count_for_genres: :environment do
  # In SQLite we can't do update_all with subquery, so we update it one by one
  count_sql = Movie.select('COUNT(*)').where('genre_id = genres.id').to_sql
  Genre.select("id, movies_count, (#{count_sql}) as counted_movies").each do |genre|
    counted_movies = genre.attributes['counted_movies']
    Genre.update_counters(genre.id, movies_count: counted_movies - genre.movies_count)
  end
end
