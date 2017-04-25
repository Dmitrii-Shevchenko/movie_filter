require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  let(:netflix) {Netflix.new('movies.txt' || ARGV[0])}
  let(:paid){netflix.pay(25)}

  it "should show movies when enough money" do
    paid
    expect(netflix.show(genre: 'Comedy', period: :new).class).to eq(Array)   
  end

  it "should raise error when not enough money" do 
    expect {netflix.show(period: :new, genre: 'Comedy')}.to raise_error    
  end  
  
  describe '#pay' do 
    it 'changes account' do 
      expect { netflix.pay(25) }.to change(netflix, :acct).by(25) 
    end
     
    it 'fails when negative amount' do
      expect {netflix.pay(-30)}.to change(netflix, :acct).by(0)
    end 
  end

  it "should shows cost of the movie" do 
    expect(netflix.how_much?('Terminator')).to eq(3)
  end
end
