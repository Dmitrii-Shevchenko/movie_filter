load 'movie.rb'
class Modern < Movie
@mov_col
  def initialize(movie,col)
    super(movie,col)
    @mov_col = col
  end
  
  def inspect
    "#{@title} - cовременное кино: играют #{@actors.join(',')}"
  end
end
