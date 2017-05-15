require_relative 'spec_helper'
require_relative '../lib/movie_module'
  describe Cashbox do
    let(:first_tht){Theatre.new('./example/movies.txt')}
    let(:second_tht){Theatre.new('./example/movies.txt')}
    
    describe '#cash' do
      describe 'for first theatre' do
        subject{first_tht.cash}
        context 'before payment' do
          it{is_expected.to eq(0)}
        end      
        context 'after payment' do
          before{first_tht.pay(5)}
          it{is_expected.to eq(['usd 5'])}
        end      
      end
     
      describe 'for second theatre' do
        before{first_tht.pay(5)}
        context'before payment' do
          subject{first_tht.cash.eql?(second_tht.cash)}
          it{is_expected.to be false}
        end     
        context'after payment' do
          before{second_tht.pay(5)}
          subject{first_tht.cash.eql?(second_tht.cash)}
          it{is_expected.to be true}
        end     
      end 
     
      describe 'for netflix' do 
        subject{second_tht.pay(5)}
        context 'before payment' do
          subject{Netflix.cash}
          it{is_expected.to eq(0)}
        end      
        context 'after payment' do
          before{Netflix.pay(10)}
          subject{Netflix.cash}
          it{is_expected.to eq(['usd 10'])}
        end      
      end
      
      describe 'for different denomination' do
        before do
          Netflix.pay(5,'USD')
          Netflix.pay(10,'EUR')
          Netflix.pay(15,'JPY')
          Netflix.pay(30,'USD')
          Netflix.pay(60,'EUR')
          Netflix.pay(120,'JPY')
        end
        subject{Netflix.cash}
        it{is_expected.to eq(['usd 45','eur 70','jpy 135'])}
      end
    end
  #-------------------------------------------------
    describe '#pay' do
      subject{first_tht.cash}
      context 'by default' do
        before{first_tht.pay(5)}
        it{is_expected.to eq(['usd 5'])}
      end
      context 'in USD' do
        before{first_tht.pay(5,'USD')}
        it{is_expected.to eq(['usd 5'])}
      end 
      context 'in EUR' do
        before{first_tht.pay(5,'EUR')}
        it{is_expected.to eq(['eur 5'])}
      end 
      context 'in JPY' do
        before{first_tht.pay(5,'JPY')}
        it{is_expected.to eq(['jpy 5'])}
      end
    end
  #-------------------------------------------------
    describe '#buy_ticket' do
      describe 'for theatre' do
        context 'by default' do
          subject{first_tht.buy_ticket}
          it{is_expected.to include('вы купили билет на')}
        end
        context 'on particular time' do
          subject{first_tht.buy_ticket('10:20')}
          it{is_expected.to include('(10:20) вы купили билет на')}
        end
      end
    end
  #-------------------------------------------------  
    describe '#take' do
      let(:who){'bank'}
      describe 'money from theatre' do
        before {first_tht.pay(5)}
        subject{first_tht.take(who)}
        context 'bank' do
          let(:who){'bank'}
          it{is_expected.to eq('Проведена инкассация')}
        end
        context 'other' do
          let(:who){'other'}
          it{expect{subject}.to raise_error('Вызов полиции')}
        end
      end
      
      describe 'money from netflix' do
        before {Netflix.pay(5)}
        subject{Netflix.take(who)}
        context 'bank' do
          let(:who){'bank'}
          it{is_expected.to eq('Проведена инкассация')}
        end
        context 'other' do
          let(:who){'other'}
          it{expect{subject}.to raise_error('Вызов полиции')}
        end
      end
    end
  end

