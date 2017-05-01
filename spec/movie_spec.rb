require 'spec_helper'
require_relative '../movie'
require_relative '../ancient'

describe Movie do
  describe '#Movie.create' do
    subject{mov = Movie.create(content,MovieCollection.new('movies.txt' || ARGV[0])).inspect }

    context 'Ancient' do
      let(:content) { ["","Ancient movie","1930","","","","","","",""] }
      it { is_expected.to eq("Ancient movie - старый фильм(1930 год)") }
    end
    
    context 'Classic' do
      let(:content) { ["","Classic movie","1960","","","","","","producer",""] }
      it { is_expected.to eq("Classic movie - классический фильм, режиссёр producer ()") }
    end
    
    context 'Modern' do
      let(:content) { ["","Modern movie","1970","","","","","","","1,2,3"] }
      it { is_expected.to eq("Modern movie - cовременное кино: играют 1,2,3") }
    end
    
    context 'New' do
      let(:content) { ["","New movie","2010","","","","","","",""] }
      it { is_expected.to eq("New movie - новинка, вышло 7 лет назад!") }
    end
  end
end
