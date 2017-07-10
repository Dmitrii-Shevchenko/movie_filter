require_relative  '../lib/movies'
include  Movies
begin
  #test netflix
  net = Netflix.new('./example/movies.txt' || ARGV[0])
  net.pay(100500)
  
  puts "FILTER: person"
  net.define_filter(:new_sci) { |movie, year| movie.year == year }
  net.define_filter(:newest_sci_f, from: :new_sci, arg: 2001)
  puts net.show(newest_sci_f: true).inspect
  
  puts "-----------------------------------------"
  
  puts net.show(genre: 'Comedy', period: :ancient).inspect 
  puts net.show(period: :ancient).inspect
  
  puts "-----------------------------------------"
  
  net.define_filter(:a) { |movie| movie.genre.include?('Horror') }
  net.define_filter(:b) { |movie| movie.year > 1970 }
  net.define_filter(:c) { |movie| movie.rate.to_d > 8.4}
  puts net.show(a: true, b: true, c: true).inspect
  #puts net.show(b: true) #, b: true, c: true)
 # puts net.show(a: true, period: :new).inspect
  puts "-----------------------------------------"
  puts net.show(b: true, genre: 'Comedy').inspect
  puts net.show(){ |movie| movie.year < 1930 }.inspect
  mov = net.show(){ |movie| movie.year < 1930 }.last
  tht = Theatre.new('./example/movies.txt' || ARGV[0])
  puts tht.show("10:20").inspect
  puts tht.when?('Terminator')
  puts net.person_acct
  puts net.how_much?('Terminator')
  puts net.how_much?(mov)
  #puts net.show(aasd: true).inspect
rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
