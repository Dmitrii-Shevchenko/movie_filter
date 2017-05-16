module Movies
  class New < Movie 
    def inspect
      "#{@title} - новинка, вышло #{Date.today.year-@year} лет назад!"
    end
  end
end
