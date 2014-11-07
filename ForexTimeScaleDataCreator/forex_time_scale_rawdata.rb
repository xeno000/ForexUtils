class ForexTimeScaleRawData
    def initialize(time_range, forex_data_record_array)
        @time_range = time_range
        @forex_data_record_array = forex_data_record_array
    end
    
    attr_reader :time_range
    attr_reader :forex_data_record_array
end