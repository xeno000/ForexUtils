class TimeRangeUtils
    def self.get_range_start(timestamp, time_scale_sec)
        amari = timestamp%time_scale_sec
        timestamp - amari
    end
    
    def self.get_range_end(timestamp, time_scale_sec)
        range_start = get_range_start(timestamp, time_scale_sec)
        range_start + time_scale_sec - 1
    end
end