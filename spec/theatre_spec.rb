require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  it "shoud show movies on time" do
    tht = Theatre.new('movies.txt' || ARGV[0])
    expect(tht.show("12:20").class).to eq(Array)
    expect(tht.show("00:30")).to eq("the ether is closed")
  end
end
