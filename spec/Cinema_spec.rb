require_relative '../Cinema'

describe Cinema do
    it "should be true" do
        expect(Cinema.new.test).to eq(true)
    end
    
    it "should shows movie" do
        expect(Cinema.new.show).to be_a(String)
    end
end
