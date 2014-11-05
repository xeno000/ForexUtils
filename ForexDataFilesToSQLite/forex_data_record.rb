require '../ForexTimeScaleDataCreator/forex_time_utils'

class ForexDataRecord
    def self.create_record_from_line(line)
        record = self.new
        if data = line.match(/([A-Z]+),([0-9]{8}),([0-9]{4})[0-9]{2},([0-9\.]+),([0-9\.]+),([0-9\.]+),([0-9\.]+)/)
            record.currency_pair = data[1]
            record.time_id = ForexTimeUtils.create_time_obj((data[2].to_s + data[3].to_s).to_i).to_i
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
        record.time_id = row['time_id'].to_i
        record.open = row['open'].to_f
        record.high = row['high'].to_f
        record.low = row['low'].to_f
        record.close = row['close'].to_f
        record
    end
    
    attr_reader :currency_pair
    attr_reader :time_id
    attr_reader :open
    attr_reader :high
    attr_reader :low
    attr_reader :close
end