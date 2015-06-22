require './forex_data_folder'
require './forex_data_url_list_page'
require './forex_data_file_downloader'
require './forex_data_file_utils'
require './forex_data_web_file'



def create_time(time_str)
    time = nil
    if time_str =~ /^(\d{4})(\d{2})(\d{2})$/
        time = Time.gm($1.to_i, $2.to_i, $3.to_i)
    end
    time
end

# nohup ruby main.rb 20070101 20160101 2007_2015 &

start_time_str = ARGV[0] #20070101
end_time_str = ARGV[1] #20100101
folder_name = ARGV[2] 

start_time = create_time(start_time_str)
end_time = create_time(end_time_str)



folder = ForexDataFolder.create(folder_name)

url2007 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2007.html"
url2008 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2008.html"
url2009 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2009.html"
url2010 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2010.html"
url2011 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2011.html"
url2012 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2012.html"
url2013 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2013.html"
url2014 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2014.html"
url2015 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv.html"

url_list_pages = [url2007, url2008, url2009, url2010, url2011, url2012, url2013, url2014, url2015]



forex_data_web_file_name_array = Array.new

url_list_pages.each do |page_url|
    forex_data_url_list_page = ForexDataUrlListPage.new(page_url)
    forex_data_url_list_page.read
    name_array = forex_data_url_list_page.select_forex_data_file_name_all
    forex_data_web_file_name_array += name_array
end



forex_data_web_file_array = Array.new

forex_data_web_file_name_array.each do |file_name|
    web_file = ForexDataWebFile.new(file_name)
    if start_time <= web_file.forex_data_time && web_file.forex_data_time <= end_time
        forex_data_web_file_array.push(web_file)
    end 
end



i = 0
total = forex_data_web_file_array.count

forex_data_web_file_array.each do |web_file|
    i += 1
    web_file.download(folder)
    p i.to_s + "/" + total.to_s + " " + web_file.file_name
end

=begin

forex_data_url_array = Array.new

urls.each do |url|
    forex_data_url_list_page = ForexDataUrlListPage.new(url)
    forex_data_url_list_page.read
    url_array = forex_data_url_list_page.select_forex_data_url_all
    forex_data_url_array += url_array
end

i = 0
total = forex_data_url_array.count

forex_data_url_array.each do |url|
    i += 1
    p i.to_s + "/" + total.to_s + " " + ForexDataFileUtils.create_file_name_from_url(url)
    ForexDataFileDownLoader.download(url, folder)
end

=end



