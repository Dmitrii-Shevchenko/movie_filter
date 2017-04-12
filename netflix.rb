load 'moviecollection.rb'
class Netflix < MovieCollection
  attr_reader :acct
  
  def show(req)
    sort_by(:rate)
    if req.value?(:ancient)
      calc(1)
      check(filter(req.delete_if {|key| key == :period}.merge({year: 1900..1945})))
    elsif req.value?(:classic)
      calc(1.5)
      check(filter(req.delete_if {|key| key == :period}.merge({year: 1945..1968})))
    elsif req.value?(:modern)
      calc(3)
      check(filter(req.delete_if {|key| key == :period}.merge({year: 1968..2000})))  
    elsif req.value?(:new)
      calc(5)
      check(filter(req.delete_if {|key| key == :period}.merge({year: 2000..2017})))
    else
      filter(req)
    end
  end
  
  def  calc(price)
    if price <= @acct
      @acct = @acct-price
    else
      raise 'havnt money for showing movie'
    end
  end
  
  def check(mvs)  #возможео сравнить клас это или массив
    if mvs.count >= 3
      mvs.fetch(rand(0..2))
    elsif mvs.count >= 2
      mvs.fetch(rand(0..1))
    elsif mvs.count >=1
      mvs.fetch(0)
    else
      raise 'this movie doesnt exist'
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
    if filter(title: /#{mov}/,year: 1900..1945).any?
      1
    elsif filter(title: /#{mov}/,year: 1945..1968).any?
      1.5
    elsif filter(title: /#{mov}/,year: 1968..2000).any?
      3
    elsif filter(title: /#{mov}/,year: 2000..2017).any?
      5
    end
  end
  
  private :check,:calc
end
