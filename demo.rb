load 'netflix.rb'
load 'theatre.rb'
begin
  #test netflix
  net = Netflix.new('movies.txt' || ARGV[0])
  net.pay(25)
  puts net.acct    
  puts net.show(genre: 'Comedy', period: :new).inspect  
  puts net.acct 
  puts net.how_much?('Elite Squad')
  
  #test thaetre
  tht = Theatre.new('movies.txt' || ARGV[0])
  puts tht.show("").inspect
  puts tht.when?('Laura')  
  
rescue Exception => err
  puts "Caught exception: #{err.message}"
  puts err.backtrace.inspect
end
