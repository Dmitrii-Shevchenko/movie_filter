load 'netflix.rb'
load 'theatre.rb'
load 'ancient.rb'
begin
  #test netflix
  net = Netflix.new('movies.txt' || ARGV[0])
  net.pay(12)
  puts net.acct    
  puts net.show(genre: 'Comedy', period: :ancient).inspect 
  
  puts net.show(period: :ancient).inspect  
    puts net.show(period: :classic).inspect 
      puts net.show(period: :modern).inspect 
        puts net.show(period: :new).inspect 
        
  puts net.acct 
  puts net.how_much?('Elite Squad')
  
  #test theatre
  tht = Theatre.new('movies.txt' || ARGV[0])
  puts tht.show("10:20").inspect
  puts tht.when?('Terminator')
  
  puts tht.buy_ticket
  puts tht.cash
#  net.pay(12)
#  puts net.cash
  #test 
#  puts MovieCollection.new('movies.txt').all.first.has_genre?('Horror')
#  puts Ancient.new(["http://imdb.com/title/tt0073195/?ref_=chttp_tt_209","Jaws","1930","USA","1975-06-20","Adventure,Drama,Thriller","124 min","8.1","Steven Spielberg","Roy Scheider,Robert Shaw,Richard Dreyfuss"],MovieCollection.new('movies.txt')).matches?(:title,'Ja') 
#    puts Ancient.new(["http://imdb.com/title/tt0073195/?ref_=chttp_tt_209","Jaws","1930","USA","1975-06-20","Adventure,Drama,Thriller","124 min","8.1","Steven Spielberg","Roy Scheider,Robert Shaw,Richard Dreyfuss"],MovieCollection.new('movies.txt')).send(:year)

rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
