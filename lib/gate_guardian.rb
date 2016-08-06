class Gate_Guardian

  def initialize(wait_time)
    puts 'RSS crawler beginning'
    payload = {text: 'starting'}.to_json
    RestClient.post 'https://hooks.slack.com/services/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', payload
    @wait_time = wait_time
    initiate
  end

  private

  def initiate
    begin
      while true
        url = 'https://www.upwork.com/ab/feed/jobs/atom?category2=web_mobile_software_dev&contractor_tier=1&sort=create_time+desc&workload=as_needed%2Cpart_time&api_params=1&q=&securityToken=98c9d225c10287f568682b2cdfb45671f6fdb5d376344848b03e08569dd57a24ee67d2988955363db5b3912e532f237829af968dc2954e4924d75c15e5403b9b&userUid=757745156799963136'
        rss = RestClient.get url
        feed = RSS::Parser.parse(rss)
        feed.entries each do |entry|
          job = Job.new(entry)
          if job.worthy
            payload = {text: "The job \"#{job.title} is worthy.\n#{job.summary}"}.to_json
            RestClient.post 'https://hooks.slack.com/services/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', payload
            file = File.open('logs', 'a+')
            file.write job.title + '  was worthy'
          end
        end
        sleep(@wait_time)
      end
    rescue StandardError => e
      puts e
      file = File.open('logs', 'a+')
      file.write e.to_s
      file.close
    end
  end
end