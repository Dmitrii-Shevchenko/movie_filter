require_relative  '../lib/movies'
include  Movies
begin
  #test netflix
  net = Netflix.new('./example/movies.txt' || ARGV[0])
  net.pay(12)
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
  #puts Netflix.cash
  tht.pay(1000,'USD')
  #money = Money.new(1000, "USD")
  #puts money.cents     #=> 1000
  #puts money.currency  #=> Currency.new("USD")
  
  
#    puts tht2.cash
  tht2.pay(25)
#    puts tht2.cash
#    
  tht.pay(30,"EUR")
  puts tht.cash
  puts tht.take('bank')
  puts tht.cash
#    puts tht2.cash
  puts tht2.buy_ticket
  puts tht2.buy_ticket("10:20")  
  puts tht2.cash
rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
