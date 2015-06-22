require './forex_time_scale'

class ForexTimeScaleDbUtils
    def self.create_table_sql(table_name)
        sql = <<-SQL 
        CREATE TABLE IF NOT EXISTS #{table_name} (
            open_minute_open_timestamp TIMESTAMP NOT NULL PRIMARY KEY,
            open REAL NOT NULL,
            high REAL NOT NULL,
            low REAL NOT NULL,
            close REAL NOT NULL,
            high_minute_close_timestamp TIMESTAMP NOT NULL UNIQUE,
            low_minute_close_timestamp TIMESTAMP NOT NULL UNIQUE,
            close_minute_close_timestamp TIMESTAMP NOT NULL UNIQUE
        );
        SQL
    end
    
    def self.create_table_name(currency_pair, time_scale)
        currency_pair + "_" + time_scale.minute.to_s + "_" + "minute"
    end
end
        