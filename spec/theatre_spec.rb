require 'spec_helper'
require_relative '../theatre'

describe Theatre do
  let(:theatre) {Theatre.new('movies.txt' || ARGV[0])}
  
  describe '#show' do
    context 'if right time' do
      it 'shoud show movies on time' do
        expect(theatre.show("12:20").class).to eq(Array)
      end
    end
    
    context 'if night time' do
      it 'shoud show movies on time' do
        expect(theatre.show("04:20").empty?).to eq(true)
      end
    end
    
    it 'should show time' do
      expect(theatre.when?('Psycho')).to eq("since 06:00 before 12:00 and since 12:00 before 18:00")
    end
  end
end
