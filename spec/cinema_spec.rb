require_relative '../cinema'

describe Cinema do       
    it "should shows movie" do
        expect(Cinema.new.show).to be_a(String)
    end
end
