require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  it "shoud show movies on time" do
    tht = Theatre.new('movies.txt' || ARGV[0])
    expect(tht.show("12:20").class).to eq(Array)
    expect(tht.show("00:30")).to eq("the ether is closed")
  end
  
  it "should show time" do
    tht = Theatre.new('movies.txt' || ARGV[0])
    expect(tht.when?('Double')).to eq("since 06:00 before 12:00")
    expect(tht.when?('Terminator')).to eq("since 12:00 before 18:00")
    expect(tht.when?('Psycho')).to eq("since 18:00 before 00:00")
  end
end
