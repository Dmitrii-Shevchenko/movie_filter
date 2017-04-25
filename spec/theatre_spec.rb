require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  let(:theatre) {Theatre.new('movies.txt' || ARGV[0])}
  
  it "shoud show movies on time" do
    expect(theatre.show("12:20").class).to eq(Array)
  end
  
  it "should show time" do
    expect(theatre.when?('Psycho')).to eq("since 06:00 before 12:00 and since 12:00 before 18:00")
  end
end
