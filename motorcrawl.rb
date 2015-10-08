require 'wombat'
require 'json'

pbmotors = Wombat.crawl do
  base_url "http://www.philbrownmotors.co.nz"
  path "/"

  pbmotors "css=div.product-meta", :iterator do
    car "css=div.product-title"
    price "css=div.product-price"
  end
end

=begin
mckendry = Wombat.crawl do
  base_url "http://mckendryford.co.nz"
  path "/used-vehicles"

  car "css=.desc h1"
  price "css=.desc span"
  end
end
=end

data = JSON.generate(pbmotors)
File.open("pbmotors_stocklist", "w") do |file|
  file.puts data
end
