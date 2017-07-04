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
    
    def show(req=nil, &block)  
      unless req then return all.select { |movie| yield(movie)}.compact end          
      if block_given?
        return req.reduce(all) {|movs, (fltr_k, fltr_v)| movs.select {|mov| mov_exist?(mov, fltr_k, fltr_v)}}.select { |movie| yield(movie)}.compact
      end
        req.reduce(all) {|movs, (fltr_k, fltr_v)| movs.select {|mov| mov_exist?(mov, fltr_k, fltr_v)}}
    end
    
    private    
        
    def mov_exist?(mov, fltr_k, fltr_v)        
      if @custom_filters.keys.include?(fltr_k)
       return block_filter(fltr_k => fltr_v).include?(mov)       
      end
        filter(fltr_k => fltr_v).include?(mov)     
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

    def block_filter(req)
      all.select { |movie| @custom_filters[req.keys.first].call(movie, req.values.first) }.compact
    end
  end
end
