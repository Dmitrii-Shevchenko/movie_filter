require_relative 'cashbox'
#
module Movies
  #
  class Netflix < MovieCollection
    extend Cashbox
    @@cash_sum = []

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

    def self.cash_sum
      @@cash_sum
    end

    def pay(mny)
      (mny > 0) ? (@person_acct += mny) : (raise 'uncorrect sum')
    end

    def how_much?(mov)
      "Movie \"#{mov}\" costs: #{define_price(mov)}"
    end

    def define_filter(name, from: nil, arg: nil, &block)
      if from.nil?
        filter_with_block(name, &block)
      else
        person_filter(name, from, arg)
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
        block_filter(mov, fltr_k, fltr_v)
      else
        filter(nil, mov, fltr_k, fltr_v)
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

    def filter_with_block(fltr_name, &block)
      @custom_filters[fltr_name] = block
    end

    def person_filter(fltr_name, from, arg)
      @custom_filters[fltr_name] = proc do |movie|
        @custom_filters[from].call(movie, arg)
      end
    end

    def block_filter(mov, fltr_k, fltr_v)
      @custom_filters[fltr_k].call(mov, fltr_v)
    end
  end
end
