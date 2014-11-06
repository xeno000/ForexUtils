class TimeRange
    def initialize(range_start, range_end)
        @range_start = range_start
        @range_end = range_end
    end
    
    attr_accessor :range_start
    attr_accessor :range_end
end