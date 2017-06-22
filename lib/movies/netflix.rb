require_relative 'cashbox'
module Movies 
  # class Netflix for online theatre
  class Netflix < MovieCollection
    extend Cashbox
    attr_reader :person_acct
    TYPES = [
      [:ancient, 1900..1945, 1],
      [:classic, 1945..1968, 1.5],
      [:modern, 1968..2000, 3], 
      [:new, 2000..2017, 5] 
    ] 
    @@cash_sum = []
    def initialize(file_name)
      super(file_name)
      sort_by(:rate)
      @person_acct = 0
      @custom_filters = {}
    end
    
    def self.cash_sum
      @@cash_sum
    end

    def pay(mny)
      if mny>0
        @person_acct = mny + @person_acct
      end
    end
    
    def how_much?(mov)
      "Movie \"#{mov}\" costs: #{TYPES.select {|type,range| filter(title: /#{mov}/,year:range).any?}.map(&:last).join.to_i}"
    end
        
    def define_filter(name, from: nil, arg: nil, &block)
      from.nil? ? filter_with_block(name, &block) : person_filter(name,from,arg)
    end
   
    def show(req=nil)
      if req
        @custom_filters.keys.include?(req.keys.first) ? block_filter(req) : simple_filter(req)
      else
        all.select { |movie| yield(movie)}.compact    
      end          
    end
    
    private 
    def calc(price)
      if price <= @person_acct
        @person_acct = @person_acct-price
      else
        raise 'havnt money for showing movie'
      end
    end
    
    def filter_with_block(fltr_name,&block)
      @custom_filters[fltr_name] = block
    end
       
    def person_filter(fltr_name, from, arg)
      @custom_filters[fltr_name] = Proc.new{ |movie| @custom_filters[from].call(movie,arg) }
    end
    
    def simple_filter(req)
      TYPES.map { |type,range,price|
      #если в массиве есть такой тип фильма то вычитаем его стоимость из суммы
        if req.value?(type)
          calc(price)
          #удаляем часть 'period:ancient' из запроса, для того что бы осталась
          #вся последовательность:
          #(genre: 'Comedy', producer: 'Spilberg',.....)
          #потому что 'period:ancient' не обработается методом 'filter()'
          filter(req.delete_if { |key| key == :period}.merge(year:range)) 
        end 
      #compact.flatten - избалвяемся из подмассивов, чтобы он был одномерный
      #сортируем его по рейтингу и возвращаем рандомный первый фильм
      }.compact.flatten.sort_by { |mov| rand * mov.rate.to_f }.first
    end
    
    #if filter have block, calculate it
    def block_filter(req)
      all.select { |movie| @custom_filters[req.keys.first].call(movie, req.values.first) }.compact
    end
  end
end
