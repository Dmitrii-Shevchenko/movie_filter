require 'time'
load 'moviecollection.rb'
class Theatre < MovieCollection
  @@t_mor = Time.parse("06:00")...Time.parse("12:00")
  @@t_aft = Time.parse("12:00")...Time.parse("18:00")
  @@t_ev = Time.parse("18:00")...Time.parse("00:00")
  @@t_night = Time.parse("00:00")...Time.parse("06:00")
  
  def initialize(file_name)
    super(file_name)
    @mor = filter(year: 1900..1945) 
    @aft = filter(genre: 'Comedy') | filter(genre: 'Action')
    @ev = filter(genre: 'Drama') | filter(genre: 'Horror')
  end

  def show(mov_time)
    if @@t_mor.include?(Time.parse(mov_time))
      @mor 
    elsif @@t_aft.include?(Time.parse(mov_time))
      @aft
    elsif @@t_ev.include?(Time.parse(mov_time))
      @ev
    elsif @@t_night.include?(Time.parse(mov_time))
      "the ether is closed"
    else
      "incorrect time"
    end
  end
  
  def when?(mov)
    if @mor.include?(filter(title: /#{mov}/).first)
      time_output(@@t_mor)
    elsif @aft.include?(filter(title: /#{mov}/).first)
      time_output(@@t_aft)
    elsif @ev.include?(filter(title: /#{mov}/).first)
      time_output(@@t_ev)
    end
  end
  
  private def time_output(time_range)
    "since #{time_range.first.strftime('%H:%M')} before #{time_range.end.strftime('%H:%M')}"
  end
end
