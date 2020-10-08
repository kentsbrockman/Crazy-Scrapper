require_relative '../lib/crypto_scrapper'

describe "#extraction_indexes" do

  it "opens the chosen URL into a page object" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    expect(page.class).to eq(Nokogiri::HTML::Document)
  end

  it "extracts the sought elements into an array (1)" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    all_crypto_indexes = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
    expect(all_crypto_indexes[0].text).to eq("BTC")
  end

  it "extracts the sought elements into an array (2)" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    all_crypto_indexes = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
    expect(all_crypto_indexes[3].text).to eq("XRP")
  end

  it "extracts an array of 200 objects" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    all_crypto_indexes = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
    expect(all_crypto_indexes.count).to eq(200)
  end


end



describe "#extraction_values" do

  it "opens the chosen URL into a page object" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    expect(page.class).to eq(Nokogiri::HTML::Document)
  end

  it "extracts an array composed of values in $" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    all_crypto_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
    expect(all_crypto_values[15].text).to include("$")
  end

  it "extracts an array of 200 objects" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    all_crypto_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
    expect(all_crypto_values.count).to eq(200)
  end

  it "converts the objects into more readable data" do
    page = Nokogiri::HTML(RestClient.get("https://coinmarketcap.com/all/views/all/"))   
    all_crypto_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
    #...
  end


end

