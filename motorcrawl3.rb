require 'mechanize'
require 'json'

scraper = Mechanize.new
scraper history_added = Proc.new { sleep 0.5 }
BASE_URL = 'http://www.philbrownmotors.co.nz/'
ADDRESS = 'http://www.philbrownmotors.co.nz/'
results = []

scraper get ADDRESS do search_page
  
end
