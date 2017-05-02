load 'movie.rb'
class Ancient < Movie
@mov_col
  def initialize(movie,col)
    super(movie,col)
    @mov_col = col
  end
  
  def inspect
    "#{@title} - старый фильм(#{@year} год)"
  end
end
