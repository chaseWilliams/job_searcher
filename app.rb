require 'rss'
require 'rest-client'
require './lib/string'
require './lib/job'
require './lib/gate_guardian'
require 'json'

url = 'http://www.ruby-lang.org/en/feeds/news.rss'
url = 'https://www.upwork.com/ab/feed/jobs/atom?category2=web_mobile_software_dev&contractor_tier=1&sort=create_time+desc&workload=as_needed%2Cpart_time&api_params=1&q=&securityToken=98c9d225c10287f568682b2cdfb45671f6fdb5d376344848b03e08569dd57a24ee67d2988955363db5b3912e532f237829af968dc2954e4924d75c15e5403b9b&userUid=757745156799963136'
url = 'https://www.upwork.com/ab/feed/jobs/atom?and_terms=backend&category2=web_mobile_software_dev&contractor_tier=1&exclude_terms=rails&sort=create_time+desc&workload=as_needed%2Cpart_time&api_params=1&q=backend+AND+NOT+rails&securityToken=98c9d225c10287f568682b2cdfb45671f6fdb5d376344848b03e08569dd57a24ee67d2988955363db5b3912e532f237829af968dc2954e4924d75c15e5403b9b&userUid=757745156799963136'
rss = RestClient.get url
  feed = RSS::Parser.parse(rss)
  feed.entry.content.content
#puts 'and now'
#puts feed.entry.content.content.html_fix
  #feed.entries.each do |item|
  #  puts "Item: #{item.title}"
  #end
#job = Job.new(feed.entries.first)
#puts job.worthy


Gate_Guardian.new 120