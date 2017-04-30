load 'movie.rb'
class New < Movie
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - новинка, вышло #{Date.today.year-@year} лет назад!"
  end
end
