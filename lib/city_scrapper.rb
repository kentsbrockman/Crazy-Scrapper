#Stack of gems
  require 'nokogiri'
  require 'open-uri'
  require 'rest-client'
  require 'xpath'

#Initialize constants that will serve to iterate on extractions of mails and build the final hash
  RAW_LIST_OF_CITIES = []
  PROCESSED_LIST_OF_CITIES = []
  CITIES_EMAILS = []

def extraction_cities
  page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/val-d-oise.html"))   
  all_cities = page.xpath('//a[@class="lientxt"]')
  all_cities.each do |ind_city|
    ind_city = ind_city.text
    RAW_LIST_OF_CITIES << ind_city
    ind_city = ind_city.downcase.tr(' ', '-')
    PROCESSED_LIST_OF_CITIES << ind_city
  end
end


def extraction_emails
  RAW_LIST_OF_CITIES.length.times do |k|
    page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/95/#{PROCESSED_LIST_OF_CITIES[k]}.html"))   
    ind_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    CITIES_EMAILS << ind_email.text
  end
end


def hash_build
  hash = Hash[RAW_LIST_OF_CITIES.zip CITIES_EMAILS]
  puts "We've got #{RAW_LIST_OF_CITIES.count} cities in the Val-d'Oise. Most of them have a contact email. Here they are :"
  hash.each do |key, value|
    puts "#{key} => #{value}"
  end
end


def perform
  extraction_cities
  extraction_emails
  hash_build
end

perform
