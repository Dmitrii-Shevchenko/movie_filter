module ModernModule
load 'movie.rb'
class Modern < MovieModule::Movie  
  def inspect
    "#{@title} - cовременное кино: играют #{@actors.join(',')}"
  end
end
end
