require 'sqlite3'
require './forex_db_table_utils'

class ForexDb 
    def initialize(currency_pair, range_string)
        @db_file_name = "forex.db"
        @table_name = ForexDbTableUtils.create_table_name(currency_pair, range_string)
    end
    
    def connect
        SQLite3::Database.new(@db_file_name)
    end
    
    def set_table
        db = connect
        db.execute(ForexDbTableUtils.create_table_sql(@table_name))
        db.close
    end
    
    def insert_forex_data_record_array(array)
        db = connect
        db.transaction do
            array.each do |record|
                p "record " + record.time_id + " " + record.currency_pair + " " + record.open
                db.execute("insert into #{@table_name} ( time_id, currency_pair, open, high, low, close) values (?,?,?,?,?,?)", record.time_id, record.currency_pair, record.open, record.high, record.low, record.close)
            end
        end
        db.close
    end
    
    def all
        db = connect
        db.execute("select * from #{@table_name}") do |row|
            p row
        end
        db.close
    end
end
        