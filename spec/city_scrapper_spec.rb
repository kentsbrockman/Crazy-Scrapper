require_relative '../lib/city_scrapper'


describe "#extraction_cities method" do

  it "opens the chosen URL into a page object" do
    page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/val-d-oise.html"))   
    expect(page.class).to eq(Nokogiri::HTML::Document)
  end

  it "extracts an array of 185 objects" do
    page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/val-d-oise.html"))   
    all_cities = page.xpath('//a[@class="lientxt"]')
    expect(all_cities.count).to eq(185)
  end

  it "extracts an array composed of names of cities" do
    page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/val-d-oise.html"))   
    all_cities = page.xpath('//a[@class="lientxt"]')
    expect(all_cities[10].text).to eq("ATTAINVILLE")
  end

end


describe "#extraction_emails method" do

  it "opens chosen URLs into page objects" do
    page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/95/#{PROCESSED_LIST_OF_CITIES[0]}.html"))   
    expect(page.class).to eq(Nokogiri::HTML::Document)
  end

  it "is meant to retrieve an email address from all of the visited URLs" do
    page = Nokogiri::HTML(RestClient.get("http://annuaire-des-mairies.com/95/#{PROCESSED_LIST_OF_CITIES[0]}.html"))   
    ind_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    expect(ind_email.text).to eq("mairie.ableiges95@wanadoo.fr")
  end

end
