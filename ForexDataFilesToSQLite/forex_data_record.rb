require '../ForexTimeScaleDataCreator/time_utils'

class ForexDataRecord
    
    def self.create_record_from_line(line)
        record = self.new
        if data = line.match(/([A-Z]+),([0-9]{8}),([0-9]{4})[0-9]{2},([0-9\.]+),([0-9\.]+),([0-9\.]+),([0-9\.]+)/)
            record.currency_pair = data[1]
            record.time_id = TimeUtils.create_time_obj((data[2].to_s + data[3].to_s).to_i).to_i
            record.open = data[4].to_f
            record.high = data[5].to_f
            record.low = data[6].to_f
            record.close = data[7].to_f
        end
        record
    end
    
    def self.create_record_from_db_row(row)
        record = self.new
        record.currency_pair = row['currency_pair']
        record.time_id = row['time_id']
        record.open = row['open']
        record.high = row['high']
        record.low = row['low']
        record.close = row['close']
        record
    end
    
    attr_accessor :currency_pair
    attr_accessor :time_id
    attr_accessor :open
    attr_accessor :high
    attr_accessor :low
    attr_accessor :close
end