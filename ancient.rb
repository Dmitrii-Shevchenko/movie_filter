load 'movie.rb'
class Ancient < Movie
attr_reader :link, :title, :year, :country, :release, :genre, :time, :rate, :producer, :actors
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - старый фильм(#{@year} год)"
  end
end
