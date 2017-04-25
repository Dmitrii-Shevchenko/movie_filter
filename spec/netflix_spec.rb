require 'spec_helper'
require_relative '../netflix'

describe Netflix do
  let(:netflix) {Netflix.new('movies.txt' || ARGV[0])}
  let(:paid){netflix.pay(25)}
  let(:minus_pay){netflix.pay(-30)}

  it "should show movies when enough money" do
    paid
    expect(netflix.show(genre: 'Comedy', period: :new).class).to eq(Array)   
  end

  it "should raise error when not enough money" do 
    expect {netflix.show(period: :new, genre: 'Comedy')}.to raise_error    
  end  
  
  it "right preparing account " do 
    paid
    expect(netflix.acct).to eq(25)
  end
  
  it "wrong preparing account " do 
    minus_pay
    expect(netflix.acct).to be nil
  end

  it "should shows cost of the movie" do 
    expect(netflix.how_much?('Terminator')).to eq(3)
  end
end
