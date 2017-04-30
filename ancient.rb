load 'movie.rb'
class Ancient < Movie
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - старый фильм(#{@year} год)"
  end
end
