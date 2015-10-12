require 'mechanize'
require 'json'

@master_arr = []


def add_to_file(data)
  File.open("car_list", "w") do |f|
    f.puts JSON.generate(data)
  end
end

def add_to_array(data)
  @master_arr << data  
end

def mckendry_scrape

agent = Mechanize.new

page = agent.get('http://mckendryford.co.nz/used-vehicles')
page2 = page.link_with(:text => 'Next »').click

listing = page.search(".car-gallery-view")
listing += page2.search(".car-gallery-view")
mckendrys =[]

listing.each do |l|
  vehicle = { "name" => l.search(".desc h1").text,
            "price" => l.search(".desc span").text,
            "link" => "http://mckendryford.co.nz" + l.search(".thumb a").attribute('href')
          }
 mckendrys << vehicle
end

add_to_array(mckendrys)

end


def mckendry2_scrape

agent = Mechanize.new

page = agent.get('http://www.mckendrys.co.nz/used-cars')
page2 = page.link_with(:text => 'Next »').click

listing = page.search(".car-gallery-view")
listing += page2.search(".car-gallery-view")
mckendrys =[]

listing.each do |l|
  vehicle = { "name" => l.search(".desc h1").text,
            "price" => l.search(".desc span").text,
            "link" => "http://www.mckendrys.co.nz" + l.search(".thumb a").attribute('href')
          }
 mckendrys << vehicle
end

add_to_array(mckendrys)

end


def richardbateman_scrape
  
  agent = Mechanize.new
  page = agent.get('http://www.richardbatemanmotors.co.nz/vehicles.aspx')
  
  listing = page.search(".vehicle-results-cell")

  rb = []

  listing.each do |l|
    vehicle = {
      "name" => l.search(".title a").text.delete!("\r\n").gsub(/\s+/, " ").strip,
      "price" => l.search(".price span").text,
      "link" => "http://www.richardbatemanmotors.co.nz/" + l.search(".title a").attribute('href')
    }
    rb << vehicle
  end

  add_to_array(rb)  

end


def seaview_scrape

  agent = Mechanize.new
  page = agent.get('http://www.seaviewwholesale.co.nz/index.php/component/vehiclemanager/118/view_user_vehicles/Graham%20H')

  listing = page.search(".okno_V")

  seaview = []

  listing.each do |l|
    vehicle = {
      "name" => l.search(".titlevehicle a").text.delete!("\r\n").strip,
      "price" => l.search(".price").text.delete!("\r\n\t").strip,
      "link" => l.search(".titlevehicle a").attribute('href')
    }
    seaview << vehicle
  end
  add_to_array(seaview)
end

def pbmotors_scrape

  agent = Mechanize.new
  page = agent.get('http://www.philbrownmotors.co.nz/')

  listing = page.search(".product")

  pbmotors = []

  listing.each do |l|
    vehicle = {
      "name" => l.search(".product-title").text,
      "price" => l.search(".product-price span").text,
      "link" => "http://www.philbrownmotors.co.nz" + l.attribute('href')
    }
    pbmotors << vehicle
  end
  add_to_array(pbmotors)
end


pbmotors_scrape
mckendry_scrape
mckendry2_scrape
seaview_scrape
richardbateman_scrape

add_to_file(@master_arr)
