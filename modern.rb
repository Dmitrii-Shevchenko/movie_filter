load 'movie.rb'
class Modern < Movie  
  def inspect
    "#{@title} - cовременное кино: играют #{@actors.join(',')}"
  end
end
