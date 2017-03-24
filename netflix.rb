load 'cinema.rb'

class Netflix < Cinema
  attr_reader :acct
  
  def show(req)
    if req.value?(:ancent) 
      @mov_clctn.filter(req.delete_if {|key| key == :period}.merge({year: 1900..1945})).inspect
    elsif req.value?(:classic)
      @mov_clctn.filter(req.delete_if {|key| key == :period}.merge({year: 1945..1968})).inspect
    elsif req.value?(:modern)    
      @mov_clctn.filter(req.delete_if {|key| key == :period}.merge({year: 1968..2000})).inspect     
    elsif req.value?(:new)    
      @mov_clctn.filter(req.delete_if {|key| key == :period}.merge({year: 2000..2017})).inspect 
    else
      @mov_clctn.filter(req).inspect
    end
  end
  
  def pay(mny)
    if !@acct.nil? and mny>0
      @acct = mny + @acct
    elsif mny>0
      @acct = mny
    end
  end
  
  def how_much?(mov)
    @mov_clctn.filter(title: /#{mov}/).inspect
  end
end
