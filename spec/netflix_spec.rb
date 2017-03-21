require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  it "should shows a movie" do 
    Netflix.new.show(genre: 'Comedy', period: :clas_mov)
  end
  it "should accepts money"
  it "should shows cost of the movie"
end
