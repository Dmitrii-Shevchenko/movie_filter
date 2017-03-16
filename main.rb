load 'movie.rb'
load 'moviecollection.rb'
begin
  movies = MovieCollection.new(ARGV[0] || 'movies.txt')
  puts movies.all.inspect	
  puts "_______________________"
  puts movies.sort_by(:title).inspect
  puts "_______________________"
  puts movies.filter(year: 2001..2005, country: /a/, genre: 'Drama').inspect
  puts "_______________________"
  puts movies.stats(:year)
  puts "_______________________"
  puts movies.all.first.actors.inspect
  puts "_______________________"
  puts movies.all[25].has_genre?('Comedy')
  puts "_______________________"
  puts movies.all.last.has_genre?('Tragedy')

end
