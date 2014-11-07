require './forex_time_scale_data_record'

class ForexTimeScaleDataRecordArrayFactory
    def self.create_array_from_rawdata_array(rawdata_array)
        record_array = Array.new
        rawdata_array.each do |rawdata|
            if 0 < rawdata.forex_data_record_array.count 
                record_array.push(ForexTimeScaleDataRecord.create_record_from_forex_data_record_array(rawdata.forex_data_record_array))
            end
        end
        record_array
    end
    
    def self.create_array_from_forex_data_record_array_array(record_array_array)
        array = Array.new
        record_array_array.each do |record_array|
            if record_array.count != 0
                forex_time_scale_data_record = ForexTimeScaleDataRecord.create_record_from_forex_data_record_array(record_array)
                array.push(forex_time_scale_data_record)
            end
        end
        array
    end
end