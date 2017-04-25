require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  let(:netflix) {Netflix.new('movies.txt' || ARGV[0])}
  
  describe '#show' do
    context 'when enough money' do
      before do
        netflix.pay(25)
      end 
      it 'should show movies' do
        expect(netflix.show(genre: 'Comedy', period: :new).class).to eq(Array)   
      end
    end

    context 'when not enough money' do
     it 'should raise error' do 
        expect {netflix.show(period: :new, genre: 'Comedy')}.to raise_error    
      end  
    end
  end
   
  describe '#pay' do 
    it 'changes account' do 
      expect { netflix.pay(25) }.to change(netflix, :acct).by(25) 
    end
     
    it 'fails when negative amount' do
      expect {netflix.pay(-30)}.not_to change(netflix, :acct)
    end 
  end

  it 'should shows cost of the movie' do 
    expect(netflix.how_much?('Terminator')).to eq(3)
  end
end
