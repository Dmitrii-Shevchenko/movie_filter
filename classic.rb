load 'movie.rb'
class Classic < Movie
@@mov_col
  def initialize(movie,col)
    super(movie)
    @@mov_col = col
  end
  
  def inspect
    "#{@title} - классический фильм, #{@producer} это известный режиссёр, ещё (#{@@mov_col.filter(producer: (@producer)).count-1}) его фильм(ов) попал(и) в топ-250"
  end
end
