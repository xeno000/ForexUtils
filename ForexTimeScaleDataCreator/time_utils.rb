class TimeUtils
    def self.create_time_obj(time_id)
        if data = time_id.to_s.match(/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/)
            year = data[1].to_i
            month = data[2].to_i
            day = data[3].to_i
            hour = data[4].to_i
            minute = data[5].to_i
            time = Time.gm(year, month, day, hour, minute, 0)
        end
    end
end