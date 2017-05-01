load 'movie.rb'
class Classic < Movie
@@mov_col
  def initialize(movie,col)
    super(movie)
    @@mov_col = col
  end
  
  def inspect
    "#{@title} - классический фильм, режиссёр #{@producer} (#{@@mov_col.filter(producer: (@producer)).map{|mov| mov.title}.last(10).join(',')})"
  end
end
