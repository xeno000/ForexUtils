class ForexTimeScaleUtils
    def self.convert_minute_from_time_scale_string(time_scale_string)
        if data = time_scale_string.match(/([0-9]+)([MHD]{1})/)
            if "M" == data[2]
                time_scale_minute = data[1].to_i
            elsif "H" == data[2]
                time_scale_minute = data[1].to_i*60
            elsif "D" == data[2]
                time_scale_minute = data[1].to_i*1440
            end
        else
            0
        end
    end
end