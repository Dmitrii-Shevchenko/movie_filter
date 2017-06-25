require_relative 'cashbox'
require 'time'
module Movies
  # class Theatre for real offline theatre
  class Theatre < MovieCollection
    include Cashbox
    attr_accessor :cash_sum
    
    COST_TIME = {
      3 => Time.parse('06:00')...Time.parse('12:00'),
      5 =>Time.parse('12:00')...Time.parse('18:00'),
      10 => Time.parse('18:00')...Time.parse('24:00')
    }.freeze
    
    def initialize(file_name)
      super(file_name)
      @day_time = {
        COST_TIME[3] => filter(year: 1900..1945),
        COST_TIME[5] => filter(genre: 'Comedy') | filter(genre: 'Action'),
        COST_TIME[10] => filter(genre: 'Horror') | filter(genre: 'Drama')
      }
      @cash_sum = []
    end

    def show(mov_time)
      check(@day_time.select { |time| time.include?(Time.parse(mov_time)) }
      .values.flatten)
    end

    def when?(mov)
      if @day_time.values.inject(all) { |sum, filter| sum - filter }
        .include?(filter(title: /#{mov}/).first)
        raise 'have not time for this movie'
      else
      check(@day_time.select { |time, movs| 
        !(movs & filter(title: /#{mov}/)).empty? }
        .keys.map { |time| time_output(time) })
      end
    end
    
    def buy_ticket(time = time_now)     
      COST_TIME.select {|cost, range_time| range_time===Time.parse(time)
        pay(cost)
        return "(#{time}) вы купили билет на #{self.show(time).sample.title}"  
      }
    end

    private
    def time_output(time_range)
      "since #{time_range.first.strftime('%H:%M')} "+
      "before #{time_range.end.strftime('%H:%M')}"
    end

    def time_now
      DateTime.now.strftime('%H:%M')  
    end
    
    def check(mov_list)
      !mov_list.empty? && (return mov_list)
      raise 'have not this movie or incorrect time'
    end
  end
end
