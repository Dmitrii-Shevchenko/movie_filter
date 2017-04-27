require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  let(:theatre) {Theatre.new('movies.txt' || ARGV[0])}
  
  describe '#show' do
    subject { theatre.show(time).first.inspect.gsub("\n","") }
    context 'morning' do
      let(:time) { '06:00' }
      it { is_expected.to eq('Casablanca | USA | ["Drama", "Romance", "War"] | 1942 | 8.6') }
    end
    
    context 'day' do
      let(:time) { '12:00' }
      it { is_expected.to eq('Life Is Beautiful | Italy | ["Comedy", "Drama", "Romance"] | 1997 | 8.6')}
    end
     
      
    context 'day' do
      let(:time) { '18:00' }
      it { is_expected.to eq('Psycho | USA | ["Horror", "Mystery", "Thriller"] | 1960 | 8.6')}            
    end
    
    context 'if night time' do
      it 'should drop error' do
        expect {theatre.show("04:20")}.to raise_error 
      end
    end   
  end
    
  describe '#when' do
    context 'if movie exists and included in ranges' do
      it 'should show movies time' do
        expect(theatre.when?('Terminator').first).to eq("since 12:00 before 18:00")
      end
    end
    
    context 'if movie doesnt exist' do
      it 'should drop error' do
        expect {theatre.when?('`')}.to raise_error
      end
    end

    context 'if movie exists but unincluded in ranges' do 
      it 'should drop error' do
        expect {theatre.when?('The Killing')}.to raise_error
      end
    end
  end
end
