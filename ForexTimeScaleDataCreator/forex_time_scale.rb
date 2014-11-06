require './forex_time_scale_utils'

class ForexTimeScale
    def initialize(time_scale_string)
        @time_scale_string = time_scale_string
        @minute = ForexTimeScaleUtils.convert_minute_from_time_scale_string(time_scale_string)
        @sec = @minute * 60
    end
    
    attr_reader :time_scale_string
    attr_reader :minute
    attr_reader :sec
end