

class Forex1MinuteDataCreator
    def initialize(currency_pair_str, forex_data_folder)
        @currency_pair_str = currency_pair_str
        @folder = forex_data_folder
        @forex_db = ForexDb.new(currency_pair_str)
        @forex_db.set_table
    end
    
    def create 
        chunk_size = 300
        i = 0
        total = 0
        chunk_array = Array.new

        @folder.all_files.each do |path|
            i += 1
            total += 1
            #p  i.to_s + " " + total.to_s + " path " + path
    
            forex_file = ForexDataFile.new(path)
            forex_file.read
            forex_data_line_array = forex_file.select_forex_data_line_array(@currency_pair_str)

            record_array = ForexDataRecordArrayFactory.create_array_from_forex_data_line_array(forex_data_line_array)
            chunk_array.concat(record_array)
    
            if i==chunk_size
                p  i.to_s + " " + total.to_s
                @forex_db.insert_forex_data_record_array(chunk_array)
                i = 0
                chunk_array = Array.new
            end
        end

        p  i.to_s + " " + total.to_s
        @forex_db.insert_forex_data_record_array(chunk_array)
    end 
end 