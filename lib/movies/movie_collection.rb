# movies
module Movies
  require 'csv'
  require 'date'
  # movie collection
  class MovieCollection
    include Enumerable
    def initialize(file_name)
      unless File.file?(file_name)
        puts "File #{file_name} isn\'t exist"
        exit
      end
      @arr_movs = CSV.read(file_name, col_sep: '|').map do |mov|
        Movie.create(mov, self)
      end
      @uniq_genres
    end

    def all
      @arr_movs
    end

    def sort_by(param)
      @arr_movs.sort_by { |mov| mov.send(param) }
    end

    def filter(requests)
        requests.reduce(@arr_movs) do |all_movs, (filter, value)|
          all_movs.select { |some_mov| some_mov.matches?(filter, value) }
        end
    end

    def stats(hsh)
      @arr_movs.group_by do |some_mov|
        some_mov.send(hsh).map { |k, v| [k, v.count] }.to_h
      end
    end

    def get_genres
      @uniq_genres ||= @arr_movs.flat_map(&:genre).uniq
    end
  end
end
