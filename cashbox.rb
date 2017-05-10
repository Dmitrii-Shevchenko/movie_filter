module Cashbox
  @@net_acct = []
  
  def cash
    theatre? ? cash_from(tht_acct) : cash_from(@@net_acct)
  end
  
  def pay(price,cup='USD')
    theatre? ? tht_acct.push(Money.new(price,cup)) : @@net_acct.push(Money.new(price,cup))
  end
       
  def buy_ticket(time=time_now)
    if theatre?
      case Time.parse(time)
        when (Theatre::DAY_TIME[0])
            pay(3)
            "(#{time}) вы купили билет на #{self.show(time_now).sample.title}"
        when (Theatre::DAY_TIME[1])
            pay(5)    
            "(#{time}) вы купили билет на #{self.show(time_now).sample.title}"
        when (Theatre::DAY_TIME[2])
            pay(10)        
            "(#{time}) вы купили билет на #{self.show(time_now).sample.title}"
        else
            '(#{Time.parse(time)}) Кинотеатр не работает'
      end      
    end
  end
  
  def take(who)
    if theatre? and who.eql?'bank'
      @tht_acct.clear
      'Проведена инкассация'
    elsif who.eql?'bank'
      @@net_acct.clear
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

  def theatre?
    self.class.eql?(Theatre)
  end
  
  def cash_from(acct)
    unless acct.empty?
      return acct.group_by{|x| x.currency}.map{|key,value| "#{key.id} #{value.reduce(0) {|sum,n| sum+n.cents} }" }
    end
    return 0
  end
  
end
