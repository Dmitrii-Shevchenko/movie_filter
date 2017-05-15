module MovieModule  
  #require_relative 'movie'
  class Modern < Movie  
    def inspect
      "#{@title} - cовременное кино: играют #{@actors.join(',')}"
    end
  end
end
