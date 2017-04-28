load 'netflix.rb'
load 'theatre.rb'
begin
  #test netflix
  net = Netflix.new('movies.txt' || ARGV[0])
  net.pay(25)
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
  
rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
