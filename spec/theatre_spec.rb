require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  before(:all) do
    @tht = Theatre.new('movies.txt' || ARGV[0])
  end
  
  it "shoud show movies on time" do
    expect(@tht.show("12:20").class).to eq(Array)
  end
  
  it "should show time" do
    expect(@tht.when?('Laura')).to eq("since 12:00 before 18:00")
    expect(@tht.when?('Psycho')).to eq("since 06:00 before 12:00 and since 12:00 before 18:00")
  end
end
