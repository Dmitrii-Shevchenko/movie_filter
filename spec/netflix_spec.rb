require_relative 'spec_helper'
require_relative '../lib/movies'
describe Netflix do
  let(:netflix) {Movies::Netflix.new('./example/movies.txt')}
  
  describe '#show' do
  
    context 'when enough money' do
      before do
        netflix.pay(25)
      end 
      it 'should show movies' do
        expect(netflix.show(genre: 'Comedy', period: :new).class).to eq(New)   
      end
      
      context 'test all periods' do        
        describe 1900..1945 do
          it { is_expected.to include(netflix.show(period: :ancient).year) }
        end
        
        describe 1945..1968 do
          it { is_expected.to include(netflix.show(period: :classic).year) }
        end
        
        describe 1968..2000 do
          it { is_expected.to include(netflix.show(period: :modern).year) }
        end
        
        describe 2000..2017 do
          it { is_expected.to include(netflix.show(period: :new).year) }
        end                 
      end 
    end
    
    context 'when not enough money' do
     it 'should raise error' do 
        expect {netflix.show(period: :new, genre: 'Comedy')}.to raise_error('havnt money for showing movie')
      end  
    end
    
    context 'when use saved filter' do
      before do
        netflix.define_filter(:new2) { |movie| movie.year < 1950}
      end
      it 'should return movie' do 
        expect(netflix.show(new2: true)).not_to be_nil
      end
    end  
    
    context 'when use not existed filter' do
      it 'should return movie' do 
        expect(netflix.show(not_existed_filter: true)).to be_nil
      end
    end  
    
    context 'when use person filter' do
      before do
        netflix.define_filter(:new_sci) { |movie, year| movie.year == year }
        netflix.define_filter(:newest_sci_fi, from: :new_sci, arg: 2001)
      end
      it 'should return movie' do 
        expect(netflix.show(newest_sci_fi: true)).not_to be_nil
      end
    end  
    
    context 'when use certain filter' do
      it 'should return certain filter' do
        expect(netflix.show { |movie| !movie.title.include?('Terminator') && 
                              movie.genre.include?('Action') && 
                              movie.year > 2008 }).not_to be_nil
      end
    end
  end
  
  describe '#define_filter' do
    let(:some_filter) { some_filter = netflix.define_filter(:new_filter) { 
        |movie, year| movie.year == year }
    }

    it 'should create a new filter(Proc)' do
      expect(some_filter).to be_a(Proc)
    end
    
    it 'should create a new filter from another' do
      expect(netflix.define_filter(:new_filter, from: :new_filter, arg: 2001)).to be_a(Proc)
    end
  end 
  
   
  describe '#pay' do 
    it 'changes account' do 
      expect { netflix.pay(25) }.to change(netflix, :person_acct).by(25) 
    end
     
    it 'fails when negative amount' do
      expect {netflix.pay(-30)}.not_to change(netflix, :person_acct)
    end 
  end

  it 'should shows cost of the movie' do 
    expect(netflix.how_much?('Terminator')).to eq('Movie "Terminator" costs: 3')
  end
end
