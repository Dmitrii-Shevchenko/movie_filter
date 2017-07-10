require_relative 'cashbox'
#
module Movies
  #
  class Netflix < MovieCollection
    extend Cashbox
    attr_reader :person_acct
    TYPES = [
      [:ancient, 1900..1945, 1],
      [:classic, 1945..1968, 1.5],
      [:modern, 1968..2000, 3],
      [:new, 2000..2017, 5]
    ].freeze

    def initialize(file_name)
      super(file_name)
      sort_by(:rate)
      @person_acct = 0
      @custom_filters = {}
    end

    def pay(mny)
      if mny > 0
        @person_acct += mny
      else
        raise 'uncorrect sum'
      end
    end

    def how_much?(mov)
      "Movie \"#{mov}\" costs: #{define_price(mov)}"
    end

    def define_filter(name, from: nil, arg: nil, &block)
      if from.nil?
        @custom_filters[name] = block
      else
        @custom_filters[name] = proc do |movie|
          @custom_filters[from].call(movie, arg)
        end
      end
    end

    def show(**filters, &block)
      res = filters.reduce(all) do |movs, (fltr_k, fltr_v)|
        movs.select do |mov|
          mov_exist?(mov, fltr_k, fltr_v) && calc(define_price(mov))
        end
      end
      block ? res.select(&block) : res
    end

    private

    def mov_exist?(mov, fltr_k, fltr_v)
      if @custom_filters.keys.include?(fltr_k)
        @custom_filters[fltr_k].call(mov, fltr_v)
      else
        mov.matches?(fltr_k, fltr_v)
      end
    end

    def define_price(mov)
      if mov.class == String
        TYPES.select do |_type, range|
          filter(title: /#{mov}/, year: range).any?
        end.flatten.last
      else
        TYPES.select do |_type, range|
          filter(title: /#{mov.title}/, year: range).any?
        end.flatten.last
      end
    end

    def calc(price)
      if price <= @person_acct
        @person_acct -= price
      else
        raise 'havnt money for showing movie'
      end
    end
  end
end
