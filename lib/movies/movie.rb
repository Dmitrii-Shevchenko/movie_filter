module Movies
  class Movie   
  attr_reader :link, :title, :year, :country, :release, 
  :genre, :time, :rate, :producer, :actors, :period
    def initialize(movie,col)
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
      @mov_col = col
    end
    
    def period
     self.class.name.downcase[8..-1].to_sym
    end
    
    def matches?(key, value)
      self_key = self.send(key)
      unless self_key.is_a?(Array)
        value===self_key
      else
        self_key.include?(value)
      end
    end

    def has_genre?(param)
      unless (@mov_col).get_genres.include? (param)
        raise "жанра #{param} не существует"
      end
      @genre.include?(param)
    end
    
    def self.create(mov,col)
      case mov[2].to_i
        when (1900..1945)
            Ancient.new(mov,col)
        when (1945..1968)
            Classic.new(mov,col)
        when (1968..2000)
            Modern.new(mov,col)
        when (2000..Date.today.year)
            New.new(mov,col)
        else
            Movie.new(mov,col)
      end
    end

    def inspect
      "#{@title} | #{@country} | #{@genre} | #{@year} | #{@rate}\n"
    end
  end
end
