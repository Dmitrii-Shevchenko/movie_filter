require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  before(:all) do
    @net = Netflix.new('movies.txt' || ARGV[0])
    @net.pay(5)
  end
  
  it "should show movies on request" do 
    expect(@net.show(genre: 'Comedy', period: :new).class).to eq(Array)
    expect {@net.show(period: :new, genre: 'Comedy')}.to raise_error    
  end 
  
  it "should accepts money" do 
    @net.pay(25)
    expect(@net.acct).to eq(25)
    @net.pay(-30)
    expect(@net.acct).to be >= 0
  end
  
  it "should shows cost of the movie" do 
    @net.pay(5)
    expect(@net.how_much?('Terminator')).to eq(3)
  end
end
