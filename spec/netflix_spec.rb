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
        expect(netflix.show(genre: 'Comedy', period: :new).class).to eq(Movie)   
      end
      
      context 'test all periods' do
        subject { netflix.show(period: per).class }
        context 'ancient' do
          let(:per) { :ancient }
          it { is_expected.to eq(Movie) }
        end    
        context 'classic' do
          let(:per) { :classic }
          it { is_expected.to eq(Movie) }
        end 
        context 'modern' do
          let(:per) { :modern }
          it { is_expected.to eq(Movie) }
        end 
        context 'new' do
          let(:per) { :new }
          it { is_expected.to eq(Movie) }
        end                 
      end
    end

    context 'when not enough money' do
     it 'should raise error' do 
        expect {netflix.show(period: :new, genre: 'Comedy')}.to raise_error('havnt money for showing movie')    
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
    expect(netflix.how_much?('Terminator')).to eq('Movie "Terminator" costs: 3')
  end
end
