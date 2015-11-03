require 'sinatra'
require 'json'


get '/' do
  @car_list = JSON.parse(File.open("car_list", "r"){ |f| f.read })  
  @ctime = File.open('car_list').ctime
 
  erb :index
end
