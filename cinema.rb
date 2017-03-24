load 'moviecollection.rb'

class Cinema
  def initialize
    @mov_clctn = MovieCollection.new('movies.txt' || ARGV[0])
  end
     
  def show
    "Now showing: (название выбранного кина) (время начала) - (время окончания)"      
  end
end
