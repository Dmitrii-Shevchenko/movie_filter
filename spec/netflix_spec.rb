require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  it "should show movies on request" do 
    net = Netflix.new('movies.txt' || ARGV[0])
    net.pay(5)
    expect(net.show(genre: 'Comedy').class).to eq(Array)
    expect(net.show(genre: 'Comedy', period: :new).class).to eq(Movie)
    begin
      net.show(period: :new, genre: 'Comedy')
    rescue Exception => err
      expect(err.message).to eq('havnt money for showing movie')
    end
  end
  
  it "should accepts money" do 
    net = Netflix.new('movies.txt' || ARGV[0])
    net.pay(25)
    expect(net.acct).to eq(25)
    net.pay(-30)
    expect(net.acct).to be >= 0
  end
  
  it "should shows cost of the movie" do 
    net = Netflix.new('movies.txt' || ARGV[0])
    net.pay(5)
    expect(net.how_much?('Terminator')).to eq(3)
  end
end
