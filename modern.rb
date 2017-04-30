load 'movie.rb'
class Modern < Movie
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - cовременное кино: играют #{@actors.join(',')}"
  end
end
