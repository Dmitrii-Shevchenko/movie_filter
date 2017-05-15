module MovieModule
  #require_relative 'movie'
  class Ancient < Movie
    def inspect
      "#{@title} - старый фильм(#{@year} год)"
    end
  end
end
