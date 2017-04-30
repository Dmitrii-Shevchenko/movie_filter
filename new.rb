load 'movie.rb'
class New < Movie
attr_reader :link, :title, :year, :country, :release, :genre, :time, :rate, :producer, :actors
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - новинка, вышло #{Date.today.year-@year} лет назад!"
  end
end
