require_relative  '../lib/movies'
include  Movies
begin
  #test netflix
  net = Netflix.new('./example/movies.txt' || ARGV[0])
  net.pay(300)
  puts net.person_acct    
  puts net.show(genre: 'Comedy', period: :ancient).inspect 
  
  puts net.show(period: :ancient).inspect  
    puts net.show(period: :classic).inspect 
      puts net.show(period: :modern).inspect 
        puts net.show(period: :new).inspect 
        
  puts net.person_acct 
  puts net.how_much?('Elite Squad')
  
  #test theatre
  tht = Theatre.new('./example/movies.txt' || ARGV[0])
  puts tht.show("10:20").inspect
  puts tht.when?('Terminator')
  tht2 = Theatre.new('./example/movies.txt' || ARGV[0])
  
  puts Netflix.cash
  puts tht.cash
  
  Netflix.pay(500,'JPY')
  Netflix.pay(1000,'USD')
  Netflix.pay(1000,'USD')
  Netflix.pay(12314,'EUR')
  Netflix.pay(500,'JPY')
  Netflix.pay(11111)
  
  
  puts Netflix.cash
  puts "-----------------------------------"
  tht.pay(1000,'USD')

  tht2.pay(25)

  tht.pay(30,"EUR")
  puts tht.cash
  puts tht.take('bank')
  puts tht.cash

  puts tht2.buy_ticket('11:30')
  puts tht2.buy_ticket("10:20")  
  puts tht2.cash
  
  puts "-----------------------------------------"
  
  puts "FILTER: define_filter(:new_sci_fi) { |movie| movie.year > 2014 }"
  net.define_filter(:new_sci_fi) { |movie| movie.year > 2014 }
  puts net.show(new_sci_fi: true).inspect
  
  puts "-----------------------------------------"
  
  net.define_filter(:new1) { |movie,year| movie.year == year}
  puts net.show(new1: 2013).inspect
  
  puts "-----------------------------------------"
  
  puts "FILTER: define_filter(:newq) { |movie| movie.year < 1950}"
  net.define_filter(:new2) { |movie| movie.year < 1950}
  puts net.show(new2: true).inspect
  
  puts "-----------------------------------------"
  
  puts "FILTER: certain"
  puts net.show { 
    |movie| !movie.title.include?('Terminator') && 
    movie.genre.include?('Action') && 
    movie.year > 2008 
  }.inspect
  
  puts "-----------------------------------------"
  puts net.show(period: :ancient).inspect
  puts "-----------------------------------------"
  
  puts "FILTER: person"
  net.define_filter(:new_sci) { |movie, year| movie.year == year }
  net.define_filter(:newest_sci_f, from: :new_sci, arg: 2001)
  puts net.show(newest_sci_f: true).inspect
  
  puts "-----------------------------------------"
  puts net.show(new2: true).inspect
  puts "-----------------------------------------"
  puts net.show(genre: 'Comedy', period: :ancient).inspect 
  puts net.show(period: :ancient).inspect
  puts "-----------------------------------------"
  puts tht.buy_ticket("10:20")
rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
