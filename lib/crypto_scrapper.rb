#Stack of gems
  #require 'rubygems' => Je vois pas en quoi c'est indispensable...
  require 'nokogiri'
  require 'open-uri'
  require 'rest-client'
  require 'xpath'
#end


#Extraction via 'rest-client'
  #page = Nokogiri::HTML(RestClient.get("http://en.wikipedia.org/"))   
  #puts page.class   # => Nokogiri::HTML::Document
#end


#Extraction via 'open-uri'
  #page = Nokogiri::HTML(URI.open("http://en.wikipedia.org/"))   
  #puts page.class   # => Nokogiri::HTML::Document
#end


#Initialize constants that will serve to build hash
  CRYPTO_INDEX = []
  CRYPTO_PRICE = []
#end


def extraction_indexes
  page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
  all_crypto_indexes = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  #Stock the index text into a constant
  all_crypto_indexes.each do |crypto|
    CRYPTO_INDEX << crypto.text
    end
end


def extraction_values
  page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))
  all_crypto_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
  #Processing the data and stock the processed values into a constant
  all_crypto_values.each do |crypto|
    crypto = crypto.text
    crypto = crypto.tr('$', '')
    crypto = crypto.tr(',', '')
    crypto = crypto.to_f
    CRYPTO_PRICE << crypto
  end
end


def hash_build
  hash = Hash[CRYPTO_INDEX.zip CRYPTO_PRICE]
  puts "We've got #{CRYPTO_INDEX.count} cryptocurrencies in total on the 1st page. There they are :"
  hash.each do |key, value|
    puts "#{key} => #{value}"
  end
end


def perform
  extraction_indexes
  extraction_values
  hash_build
end


perform