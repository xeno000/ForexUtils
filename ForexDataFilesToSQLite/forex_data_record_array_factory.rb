require './forex_data_record'

class ForexDataRecordArrayFactory
    def self.create_array_from_forex_data_line_array(array)
        @array = Array.new
        array.each do |line|
            record = ForexDataRecord.new(line)
            @array.push(record)
        end
        @array
    end
end