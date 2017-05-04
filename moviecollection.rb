require 'csv'
require 'date'
load 'movie.rb'
class MovieCollection
  include Enumerable
  def initialize(file_name)
    if !File.file?(file_name)
      puts "File #{file_name} isn\'t exist"
      exit
    end
    @arr_movs = CSV.read(file_name, {col_sep: '|'}).map {|mov| Movie.create(mov,self)}
    @uniq_genres
  end

  def all
    @arr_movs
  end

  def sort_by(param)
    @arr_movs.sort_by {|mov| mov.send(param)}
  end

  def filter(requests)
    requests.reduce(@arr_movs) {|movs,(filter, value)| movs.select{|mov| mov.matches?(filter, value)}}
  end

  def stats(hsh)
    @arr_movs.group_by{|mov| mov.send(hsh)}.map{|k,v| [k, v.count] }.to_h
  end

  def get_genres
    @uniq_genres ||= @arr_movs.flat_map(&:genre).uniq
  end
end
