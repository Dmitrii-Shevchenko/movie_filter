load 'movie.rb'
class New < Movie
attr_reader :link, :title, :year, :country, :release, :genre, :time, :rate, :producer, :actors
  def initialize(movie)
    @link = movie[0]
    @title = movie[1]
    @year = movie[2].to_i
    @country = movie[3]
    @release = movie[4]
    @genre = movie[5].split(",")
    @time = movie[6]
    @rate = movie[7]
    @producer = movie[8]
    @actors = movie[9].split(",")
  end
  
  def inspect
    "#{@title} - новинка, вышло #{Date.today.year-@year} лет назад!"
  end
end
