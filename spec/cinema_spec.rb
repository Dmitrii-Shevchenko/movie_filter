require 'spec_helper'
require_relative '../cinema'

describe Cinema do    
  it "assign 4 movie types" do 
  end
       
  it "should shows a movie" do
    expect(Cinema.new.show).to be_a(String)
  end
end
