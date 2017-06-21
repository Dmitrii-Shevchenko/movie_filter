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
      @blocks = {}
    end
    
    def self.cash_sum
      @@cash_sum
    end
    
    private def  calc(price)
      if price <= @person_acct
        @person_acct = @person_acct-price
      else
        raise 'havnt money for showing movie'
      end
    end
     
    def pay(mny)
      if mny>0
        @person_acct = mny + @person_acct
      end
    end
    
    def how_much?(mov)
      "Movie \"#{mov}\" costs: #{TYPES.select {|type,range| filter(title: /#{mov}/,year:range).any?}.map(&:last).join.to_i}"
    end
        
    #define filter
    def define_filter(*args,&block)
      case args.length
      when 1
        filter_with_block(*args,&block)
      when 2
        person_filter(*args)
      else
        puts "Filter not determined"
      end
    end

    private def filter_with_block(fltr_name,&block)
      @blocks[fltr_name] = block
    end
       
    private def person_filter(fltr_name, from:, arg:)
      @blocks[fltr_name] = Proc.new{ |movie| @blocks[from].call(movie,arg) }
    end
    
    #show    
    def show(req=nil)
      if req
        @blocks.keys.include?(req.keys.first) ? block_filter(req) : simple_filter(req)
      else
        all.map { |movie| if yield(movie) then movie.title end }.compact    
      end          
    end
    
    private def simple_filter(req)
      TYPES.map { |type,range,price| if req.value?(type) then calc(price); 
      filter(req.delete_if { |key| key == :period}.merge(year:range)) end }
      .compact.flatten.sort_by { |mov| rand * mov.rate.to_f }.first.inspect
    end
    
    private def block_filter(req)
      all.map { |movie|  movie.title if @blocks[req.keys.first].call(movie, req.values.first) }.compact
    end
  end
end
