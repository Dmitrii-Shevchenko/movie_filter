load 'movie.rb'
class Ancient < Movie
  def inspect
    "#{@title} - старый фильм(#{@year} год)"
  end
end
