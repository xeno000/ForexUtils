class ForexTimeScaleDataRecord
    def self.create_record_from_forex_data_record_array(array)
        record = self.new
        open_record = array.min do |a,b| a.time_id <=> b.time_id end
        high_record = array.max do |a,b| a.high <=> b.high end
        low_record = array.min do |a,b| a.low <=> b.low end
        close_record = array.max do |a,b| a.time_id <=> b.time_id end
        record.open = open_record.open
        record.high = high_record.high
        record.low = low_record.low
        record.close = close_record.close
        record.open_minute_open_timestamp = open_record.time_id
        record.high_minute_close_timestamp = high_record.time_id
        record.low_minute_close_timestamp = low_record.time_id
        record.close_minute_close_timestamp = close_record.time_id
        record
    end
        
    attr_accessor :open
    attr_accessor :high
    attr_accessor :low
    attr_accessor :close
    attr_accessor :open_minute_open_timestamp
    attr_accessor :high_minute_close_timestamp
    attr_accessor :low_minute_close_timestamp
    attr_accessor :close_minute_close_timestamp # closeの一分足のopen(始値)のタイムスタンプ closeの時刻はこれに+59秒
    
end
    