load 'movie.rb'
class Modern < Movie
attr_reader :link, :title, :year, :country, :release, :genre, :time, :rate, :producer, :actors
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - cовременное кино: играют #{@actors.join(',')}"
  end
end
