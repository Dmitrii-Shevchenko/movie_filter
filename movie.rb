require_relative 'ancient'
require_relative 'classic'
require_relative 'modern'
require_relative 'new'
class Movie  attr_reader :link, :title, :year, :country, :release, :genre, :time, :rate, :producer, :actors
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

  def matches?(key, value)
    self_key = self.send(key)
    if !self_key.is_a?(Array)
      value===self_key
    else
      self_key.include?(value)
    end
  end

  def has_genre?(param)
    if !(MovieCollection.new(ARGV[0] || 'movies.txt')).get_genres.include? (param)
      raise
    else 
      @genre.include?(param)
    end
  end
  
  def self.create(mov)
    if (1900..1945).include?(mov[2].to_i)
      Ancient.new(mov)
    elsif (1945..1968).include?(mov[2].to_i)
      Classic.new(mov)
    elsif (1968..2000).include?(mov[2].to_i)
      Modern.new(mov)
    elsif (2000..Date.today.year).include?(mov[2].to_i)
      New.new(mov)
    else
      Movie.new(mov)
    end
  end

  def inspect
    "#{@title} | #{@country} | #{@genre} | #{@year} | #{@rate}\n"
  end
end
