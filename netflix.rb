load 'moviecollection.rb'
class Netflix < MovieCollection
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
    TYPES.map {|type,range,price| if req.value?(type) then 
      calc(price); filter(req.delete_if {|key| key == :period}.merge(year:range)) end }.compact     
  end
  
  private def  calc(price)
    if price <= @acct
      @acct = @acct-price
    else
      raise 'havnt money for showing movie'
    end
  end
  
  private def check(mvs)
    mvs.fetch(rand(0...mvs.count))
  end
   
  def pay(mny)
    if !@acct.nil? and mny>0
      @acct = mny + @acct
    elsif mny>0
      @acct = mny
    end
  end
  
  def how_much?(mov)
    TYPES.select {|type,range| filter(title: /#{mov}/,year:range).any?}.map(&:last).join.to_i
  end
end
