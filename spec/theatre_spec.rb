module MovieModule   
  require 'spec_helper'
  require_relative '../theatre'

  describe Theatre do
    let(:theatre) {Theatre.new('movies.txt')}
    
    describe '#show' do
      subject { theatre.show(time).first.inspect.gsub("\n","") }
      context 'morning' do
        let(:time) { '06:00' }
        it { is_expected.to eq('Casablanca - старый фильм(1942 год)') }
      end
      
      context 'day' do
        let(:time) { '12:00' }
        it { is_expected.to eq('Life Is Beautiful - cовременное кино: играют Roberto Benigni,Nicoletta Braschi,Giorgio Cantarini')}
      end
       
        
      context 'day' do
        let(:time) { '18:00' }
        it { is_expected.to eq('Psycho - классический фильм, Alfred Hitchcock это известный режиссёр, ещё (7) его фильм(ов) попал(и) в топ-250')}            
      end
      
      context 'if night time' do
        it 'should drop error' do
          expect {theatre.show("04:20")}.to raise_error('have not this movie or incorrect time')
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
          expect {theatre.when?('`')}.to raise_error('have not this movie or incorrect time')
        end
      end

      context 'if movie exists but unincluded in ranges' do 
        it 'should drop error' do
          expect {theatre.when?('The Killing')}.to raise_error('have not time for this movie')
        end
      end
    end
  end
end
