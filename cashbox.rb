#require_relative 'theatre'
module Cashbox
  @@acct = 0
  
  def cash
    theatre? ? get_theatre : @@acct
  end
  
  def pay(price)
    theatre? ? pay_theatre(price) : @@acct += price
  end
#-------------------------------------------
  
  def buy_ticket
    if(Theatre::DAY_TIME[0].include?(Time.parse(time_now)))
      pay_theatre(3)
      "вы купили билет на #{self.show(time_now).sample.title}"
    elsif(Theatre::DAY_TIME[1].include?(Time.parse(time_now)))
      pay_theatre(5)    
      "вы купили билет на #{self.show(time_now).sample.title}"
    elsif(Theatre::DAY_TIME[2].include?(Time.parse(time_now)))
      pay_theatre(10)        
      "вы купили билет на #{self.show(time_now).sample.title}"
    end
  end
  
  def take(who)
    if theatre? and who.eql?'bank'
      @tht_acct.clear
      'Проведена инкассация'
    elsif who.eql?'bank'
      @@acct = 0
      'Проведена инкассация'
    else
      raise 'Вызов полиции'
    end
  end
  
#------------------------------------------- 

  private
  def time_now
    DateTime.now.strftime('%H:%M')  
  end
  
  def tht_acct
    @tht_acct ||= []
  end

  def pay_theatre(obj)
    tht_acct.push(obj)
  end

  def get_theatre
    tht_acct.reduce(0) { |n, value| n + value }
  end
  
  def theatre?
    self.class.eql?(Theatre)
  end
end
