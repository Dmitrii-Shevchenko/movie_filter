module NewModule
load 'movie.rb'
class New < MovieModule::Movie 
  def inspect
    "#{@title} - новинка, вышло #{Date.today.year-@year} лет назад!"
  end
end
end
