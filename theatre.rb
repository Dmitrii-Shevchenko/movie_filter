require 'time'
load 'moviecollection.rb'
class Theatre < MovieCollection
  @@morning = Time.parse("06:00")..Time.parse("11:59")
  @@day = Time.parse("12:00")..Time.parse("17:59")
  @@evening = Time.parse("18:00")..Time.parse("23:59")
  @@night = Time.parse("00:00")..Time.parse("05:59")
  
  def show(mov_time)  #возможно вызвать родительский метод show
    if @@morning.include?(Time.parse(mov_time))
      filter(year: 1900..1945) 
    elsif @@day.include?(Time.parse(mov_time))
      filter(genre: 'Comedy') | filter(genre: 'Action')
    elsif @@evening.include?(Time.parse(mov_time))
      filter(genre: 'Drama') | filter(genre: 'Horror')
    elsif @@night.include?(Time.parse(mov_time))
      "the ether is closed"
    else
      "incorrect time"
    end
  end
end
