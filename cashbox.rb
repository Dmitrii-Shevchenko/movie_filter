module Cashbox
  def cash
    unless cash_sum.empty?
      return cash_sum.group_by{|x| x.currency}.map{|key,value| "#{key.id} #{value.reduce(0) {|sum,n| sum+n.cents} }" }
    end
    return 0
  end
  
  def pay(price,cup='USD')
    cash_sum.push(Money.new(price,cup))   
  end

  def take(who)
    if who.eql?'bank'
      cash_sum.clear
      'Проведена инкассация'
    else
      raise 'Вызов полиции'
    end
  end
end
