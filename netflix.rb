load 'moviecollection.rb'
require_relative 'cashbox'
class Netflix < MovieCollection
  extend Cashbox
  attr_reader :acct
  TYPES = [
    [:ancient, 1900..1945, 1],
    [:classic, 1945..1968, 1.5],
    [:modern, 1968..2000, 3], 
    [:new, 2000..2017, 5] 
  ]
    
  def initialize(file_name)
    super(file_name)
    sort_by(:rate)
    @acct = 0
  end
  
  def show(req)
    TYPES.map {|type,range,price| if req.value?(type) then calc(price); 
      filter(req.delete_if {|key| key == :period}.merge(year:range)) end }
      .compact.flatten.sort_by {|mov| rand * mov.rate.to_f}.first
  end
  
  private def  calc(price)
    if price <= @acct
      @acct = @acct-price
    else
      raise 'havnt money for showing movie'
    end
  end
   
  def pay(mny)
    if mny>0
      @acct = mny + @acct
    end
  end
  
  def how_much?(mov)
    "Movie \"#{mov}\" costs: #{TYPES.select {|type,range| filter(title: /#{mov}/,year:range).any?}.map(&:last).join.to_i}"
  end
end
