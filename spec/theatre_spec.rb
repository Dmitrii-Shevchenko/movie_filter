require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  let(:theatre) {Theatre.new('movies.txt' || ARGV[0])}
  
  describe '#show' do
    context 'if right time' do
      it 'shoud show movies in morning time' do
        expect(theatre.show("06:00").first.inspect.gsub("\n","")).to eq('Casablanca | USA | ["Drama", "Romance", "War"] | 1942 | 8.6')
      end
      
      it 'shoud show movies in afternoon time' do
        expect(theatre.show("12:00").first.inspect.gsub("\n","")).to eq('Life Is Beautiful | Italy | ["Comedy", "Drama", "Romance"] | 1997 | 8.6')
      end
      
      it 'shoud show movies on evening time' do
        expect(theatre.show("18:00").first.inspect.gsub("\n","")).to eq('Psycho | USA | ["Horror", "Mystery", "Thriller"] | 1960 | 8.6')
      end            
    end
    
    context 'if night time' do
      it 'shoud show movies on time' do
        expect(theatre.show("04:20").empty?).to eq(true)
      end
    end   
  end
    
  describe '#when' do
    it 'should show time' do
      expect(theatre.when?('Psycho')).to eq("since 06:00 before 12:00 and since 12:00 before 18:00")
    end
  end
end
