module AncientModule
load 'movie.rb'
class Ancient < MovieModule::Movie
  def inspect
    "#{@title} - старый фильм(#{@year} год)"
  end
end
end
