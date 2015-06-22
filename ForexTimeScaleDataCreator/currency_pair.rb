class CurrencyPair
    attr_accessor :base_currency_str, :quote_currency_str
    
    def initialize(currency_pair_str)
        if currency_pair_str =~ /([a-z]+)_([a-z]+)/i
            @base_currency_str = $1.upcase
            @quote_currency_str = $2.upcase
        end
    end
end