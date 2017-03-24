require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  it "should show movies on request" do 
    net = Netflix.new
    expect(net.show(genre: 'Comedy')).not_to eq(nil)
    expect(net.show(genre: 'Comedy', period: :classic)).not_to eq(nil)
  end
  
  it "should accepts money" do 
    net = Netflix.new
    net.pay(25)
    expect(net.acct).to eq(25)
    net.pay(-30)
    expect(net.acct).to be >= 0
  end
  
  it "should shows cost of the movie" do 
    net = Netflix.new
    expect(net.how_much?('Terminator')).to eq(Object)
  end
end
