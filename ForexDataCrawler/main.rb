require './forex_data_folder'
require './forex_data_url_list_page'
require './forex_data_file_downloader'
require './forex_data_file_utils'



folder = ForexDataFolder.create("2007_2014")

url2007 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2007.html"
url2008 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2008.html"
url2009 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2009.html"
url2010 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2010.html"
url2011 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2011.html"
url2012 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2012.html"
url2013 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv_2013.html"
url2014 = "http://www.forexite.com/free_forex_quotes/forex_history_arhiv.html"

urls = [url2007, url2008, url2009, url2010, url2011, url2012, url2013, url2014]

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
    #ForexDataFileDownLoader.download(url, folder)
end


