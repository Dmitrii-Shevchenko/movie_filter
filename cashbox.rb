module Cashbox
  @@acct = 0

  def cash
    return @@acct
  end
  
  def Cashbox.pay(price)
    @@acct += price
  end
  
#один модуль на все кино, нужно сделать разные  
  
  def buy_ticket
  end
  
  def take(who)
  end
  
  
end
