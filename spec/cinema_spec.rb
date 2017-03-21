require 'spec_helper'
require_relative '../cinema'

describe Cinema do    
  it "assign 4 movie types" do 
    cinema = Cinema.new
    expect(cinema.anc_mov).not_to eq(nil)
    expect(cinema.clas_mov).not_to eq(nil)
    expect(cinema.mod_mov).not_to eq(nil)
    expect(cinema.new_mov).not_to eq(nil)
  end
       
  it "should shows a movie" do
    expect(Cinema.new.show).to be_a(String)
  end
end
