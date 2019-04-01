require 'sinatra'
require 'json'
require 'open-uri'

def get_values(json, cep_wanted)
  range_wanted = []
  cep_wanted = cep_wanted.to_i
  json.each do |range|
    range.find do |k,v|
      if range["weight_from"] == "0,010" && range["cep_from"] < cep_wanted && range["cep_to"] > cep_wanted
        range_wanted << range
      end
    end
  end
  range_wanted.first
end



get '/' do
  erb :index
end

post '/' do
  request_uri = "https://raw.githubusercontent.com/diegolearnstocode/cep_lookup/master/base.json"
  request_query = ''
  url = "#{request_uri}#{request_query}"
  buffer = open(url).read
  json = JSON.parse(buffer)
  cep = params["cep"]
  @values = get_values(json,cep)
  time_from_table = @values["time"]
  @city = @values["city"]
  time = time_from_table + 2
  @time = time.to_s
  erb :index
end

#<!--<%= @values.nil? ? "Nothing here" : "#{@time} days to #{@city}" =%>-->
