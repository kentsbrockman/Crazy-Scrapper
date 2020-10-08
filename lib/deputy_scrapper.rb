#Stack of gems
  require 'nokogiri'
  require 'open-uri'
  require 'rest-client'
  require 'xpath'
  require 'pry'
#end


#Initialize constants that will serve to iterate on extractions of mails and build the final hash
  RAW_LIST_OF_DEPUTIES = []
  FIRST_NAMES = []
  LAST_NAMES = []
  DEPUTY_PAGERS = []
  EMAILS = []
#end


def extraction_deputy_list
  page = Nokogiri::HTML(RestClient.get("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))   
  full_list_of_deputies = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
  full_list_of_deputies.each do |indiv_deputy|
    indiv_deputy = indiv_deputy.text
    RAW_LIST_OF_DEPUTIES << indiv_deputy
      if indiv_deputy[0..2] == "M. "
        indiv_deputy = indiv_deputy[3..-1]
      else
        indiv_deputy = indiv_deputy[4..-1]
      end
    indiv_deputy = indiv_deputy.split
    FIRST_NAMES << indiv_deputy[0]
    LAST_NAMES << indiv_deputy[1]
  end
end


def extraction_pager_links
  page = Nokogiri::HTML(RestClient.get("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))   
  all_pagers = page.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href')
  all_pagers.each do |ind_pager|
    DEPUTY_PAGERS << ind_pager
  end
end


def extraction_emails
  597.times do |k|
    page = Nokogiri::HTML(RestClient.get("http://www2.assemblee-nationale.fr#{DEPUTY_PAGERS[k]}"))
    ind_email = page.xpath('//article/div[3]/div/dl/dd[4]/ul/li[2]/a')
    EMAILS << ind_email.text
  end
end


def hash_build

  i = 0

  while i < 577
    compiled_data = {"first_name": FIRST_NAMES[i], "last_name": LAST_NAMES[i], "email": EMAILS[i]}
    puts compiled_data
    i = i + 1
  end

end


def perform
  extraction_deputy_list
  extraction_pager_links
  extraction_emails
  hash_build
end


perform
