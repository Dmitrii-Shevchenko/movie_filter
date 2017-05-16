require_relative 'cashbox'
require 'time'
module Movies
  class Theatre < MovieCollection
    include Cashbox
    attr_accessor :cash_sum
    DAY_TIME = [
      Time.parse("06:00")...Time.parse("12:00"),
      Time.parse("12:00")...Time.parse("18:00"),
      Time.parse("18:00")...Time.parse("24:00")
    ]
    
    def initialize(file_name)
      super(file_name)
      @day_time = { 
        DAY_TIME[0] => filter(year: 1900..1945),
        DAY_TIME[1] => filter(genre: 'Comedy') | filter(genre: 'Action'),
        DAY_TIME[2] => filter(genre: 'Horror') | filter(genre: 'Drama') 
      }
      @cash_sum = []
    end

    def show(mov_time)
      check(@day_time.select {|time,movs| time.include?(Time.parse(mov_time)) }.values.flatten)
    end

    private def check(mov_list)
      if mov_list.empty?
        raise 'have not this movie or incorrect time'
      else
        mov_list
      end
    end
    
    def when?(mov)
      if @day_time.values.inject( all() ) {|sum,filter| sum-filter}.include?(filter(title: /#{mov}/).first)
        raise 'have not time for this movie'
      else
      check(@day_time.select {|time,movs| !(movs & filter(title: /#{mov}/)).empty? }
        .keys.map {|time| time_output(time)})
      end   
    end
    
    def buy_ticket(time=time_now)
      case Time.parse(time)
        when (DAY_TIME[0])
            pay(3)
            "(#{time}) вы купили билет на #{self.show(time_now).sample.title}"
        when (DAY_TIME[1])
            pay(5)    
            "(#{time}) вы купили билет на #{self.show(time_now).sample.title}"
        when (DAY_TIME[2])
            pay(10)        
            "(#{time}) вы купили билет на #{self.show(time_now).sample.title}"
        else
            '(#{Time.parse(time)}) Кинотеатр не работает'
      end      
    end
    
    private 
    def time_output(time_range)
      "since #{time_range.first.strftime('%H:%M')} before #{time_range.end.strftime('%H:%M')}"
    end
    
    def time_now
    DateTime.now.strftime('%H:%M')  
    end
  end
end
