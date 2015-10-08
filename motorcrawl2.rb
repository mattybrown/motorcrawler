require 'wombat'
require 'json'

def add_to_file(data)
  json = JSON.generate(data)
  File.open("car_list", "a") do |f|
    f.puts json
  end
end

pbmotors = Wombat.crawl do
  base_url "http://www.philbrownmotors.co.nz"
  path "/"

  vehicle "css=.product", :iterator do
    name "css=div.product-title"
    price "css=div.product-price"
  end

end


mckendry = Wombat.crawl do
  base_url "http://mckendryford.co.nz"
  path "/used-vehicles"

    vehicle "css=.car-gallery-view", :iterator do
      name "css=.desc h1"
      price "css=.desc span"
    end

end

mckendry2 = Wombat.crawl do
  base_url "http://mckendryford.co.nz"
  path "/used-vehicles/2"
  
    vehicle "css=.car-gallery-view", :iterator do
      name "css=.desc h1"
      price "css=.desc span"
    end

end

File.delete("car_list")

dealer_compile = Array.new
dealer_compile << pbmotors
dealer_compile << mckendry
dealer_compile << mckendry2

add_to_file(dealer_compile)
