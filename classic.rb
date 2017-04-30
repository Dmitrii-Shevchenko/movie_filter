load 'movie.rb'
class Classic < Movie
attr_reader :link, :title, :year, :country, :release, :genre, :time, :rate, :producer, :actors
  def initialize(movie)
    super(movie)
  end
  
  def inspect
    "#{@title} - классический фильм, режиссёр #{@producer} (#{MovieCollection.new(ARGV[0] || 'movies.txt').filter(producer: (@producer)).map{|mov| mov.title}.last(10).join(',')})"
  end
 
end
