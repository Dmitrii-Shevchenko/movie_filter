load 'cinema.rb'
load 'netflix.rb'
begin
  net = Netflix.new
  puts net.show(genre: 'Comedy', period: :classic)
  net.pay(25)
  puts net.acct
  net.pay(25)
  puts net.acct
  puts net.how_much?('Terminator')
#  movies = MovieCollection.new(ARGV[0] || 'movies.txt')  
#  puts movies.all.inspect	
#  puts "_______________________"
#  puts movies.sort_by(:title).inspect
#  puts "_______________________"
#  puts movies.filter(year: 2001..2005, country: /a/, genre: 'Drama').inspect
#  puts "_______________________"
#  puts movies.stats(:year)
#  puts "_______________________"
#  puts movies.all.first.actors.inspect
#  puts "_______________________"
#  puts movies.all[25].has_genre?('Comedy')
#  puts "_______________________"
#  puts movies.all.last.has_genre?('Tragedy')
#rescue StandardError => error
#  puts "#{error.class}"
#  puts error.backtrace.inspect
end
