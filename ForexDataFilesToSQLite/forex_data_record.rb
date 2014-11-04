class ForexDataRecord
    def initialize(line)
        line.match(/([A-Z]+),([0-9]{8}),([0-9]{4})[0-9]{2},([0-9\.]+),([0-9\.]+),([0-9\.]+),([0-9\.]+)/) do |data|
            @currency_pair = data[1]
            @time_id = (data[2].to_s + data[3].to_s).to_i
            @open = data[4].to_f
            @high = data[5].to_f
            @low = data[6].to_f
            @close = data[7].to_f
        end
    end
    
    attr_reader :currency_pair
    attr_reader :time_id
    attr_reader :open
    attr_reader :high
    attr_reader :low
    attr_reader :close
end