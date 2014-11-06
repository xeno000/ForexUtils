require './time_range'
require './time_range_utils'
require './forex_time_scale'

class TimeRangeArrayFactory
    def self.create_array(start_timestamp, end_timestamp, time_scale)
        array = Array.new
        range_start = TimeRangeUtils.get_range_start(start_timestamp, time_scale.sec)
        range_end = TimeRangeUtils.get_range_end(start_timestamp, time_scale.sec)
        while end_timestamp > range_end
            record_range = TimeRange.new(range_start, range_end)
            array.push(record_range)
            range_start = range_start + time_scale.sec
            range_end = range_start + time_scale.sec - 1
        end
        array
    end
end