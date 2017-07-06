require_relative 'cashbox'
module Movies 
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
      (mny>0) ? (@person_acct += mny) : (raise "uncorrect sum")
    end
    
    def how_much?(mov)
      "Movie \"#{mov}\" costs: #{TYPES.select {|type,range| filter(title: /#{mov}/,year:range).any?}.map(&:last).join.to_i}"
    end
        
    def define_filter(name, from: nil, arg: nil, &block)
      from.nil? ? filter_with_block(name, &block) : person_filter(name,from,arg)
    end 
    
    def show(**filters, &block)  
      res = filters.reduce(all) {|movs, filter| movs.select {|mov| mov_exist?(mov, Hash[*filter])}}
      block ? res.select(&block) : res
    end
    
    private    
 
    def mov_exist?(mov, filter)     
      if @custom_filters.keys.include?(filter.keys.first)
        block_filter(filter, mov)
      else
        filter(filter,mov)  
      end   
    end
  
    def calc(price)
      if price <= @person_acct
        @person_acct -= price
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

    def block_filter(filter, mov)
      @custom_filters[filter.keys.first].call(mov, filter.values.first)
    end
  end
end
