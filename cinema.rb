load 'moviecollection.rb'

class Cinema
attr_reader :anc_mov, :clas_mov, :mod_mov, :new_mov
  def initialize
    mov_col = MovieCollection.new('movies.txt' || ARGV[0])
    @anc_mov = mov_col.filter(year: 1900..1945)
    @clas_mov = mov_col.filter(year: 1945..1968)
    @mod_mov = mov_col.filter(year: 1968..2000)
    @new_mov = mov_col.filter(year: 2000..2017)
  end
     
  def show
    "Now showing: (название выбранного кина) (время начала) - (время окончания)"
  end
end
