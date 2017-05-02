load 'movie.rb'
class New < Movie
@mov_col
  def initialize(movie,col)
    super(movie,col)
    @mov_col = col
  end
  
  def inspect
    "#{@title} - новинка, вышло #{Date.today.year-@year} лет назад!"
  end
end
