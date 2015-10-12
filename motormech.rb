require 'mechanize'
require 'json'


def add_to_file(data)
  File.open("car_list", "a") do |f|
    f.puts JSON.generate(data)
  end
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

add_to_file(mckendrys)

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

add_to_file(mckendrys)

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

  add_to_file(rb)  

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
  add_to_file(seaview)
end

