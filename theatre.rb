require 'time'
load 'moviecollection.rb'
class Theatre < MovieCollection
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
  end

  def show(mov_time)
    @day_time.select {|time,movs| time.include?(Time.parse(mov_time)) }.values    
  end
  
  def when?(mov)
    @day_time.select {|time,movs| (movs & filter(title: /#{mov}/)).empty? }
      .keys.map {|time| time_output(time)}.join(" and ")
  end
  
  private def time_output(time_range)
    "since #{time_range.first.strftime('%H:%M')} before #{time_range.end.strftime('%H:%M')}"
  end
end
