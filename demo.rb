load 'netflix.rb'
load 'theatre.rb'
begin
  #test netflix
  net = Netflix.new('movies.txt' || ARGV[0])
  net.pay(25)
  puts net.acct    
  puts net.show(genre: 'Comedy', period: :new).inspect  
  puts net.acct 
  puts net.how_much?('Terminator')
  
  #test thaetre
  tht = Theatre.new('movies.txt' || ARGV[0])
  puts tht.show("10:20").inspect
  puts tht.when?('Psycho')  
  
rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
