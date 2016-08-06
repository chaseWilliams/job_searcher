require 'csv'
require 'redis'
require 'json'
class Job
  @@db = Redis.new
  attr_accessor :worthy, :title, :summary
  def initialize(feed_entry)
    @title = feed_entry.title.content
    @summary = feed_entry.content.content.html_fix
    @worthy = worthy_check
  end

  private
  def worthy_check
    puts @title
    puts @summary
    if @@db.exists @title
      puts 'it exists'
      return @@db.get(@title) == 'worthy'
    end
    is_worthy = false
    json_path = File.expand_path('../words.json', __FILE__)
    words = JSON.parse File.read(json_path)
    print words
    words['good'].each do |pattern|
      puts 'check'
      if (@title.contains pattern) || (@summary.contains pattern)
        puts 'entered here'
        words['bad'].each do |stop_word|
          print stop_word
          puts @title.contains stop_word
          puts @summary.contains stop_word
          unless (@title.contains stop_word) || (@summary.contains stop_word)
            puts 'boom'
            is_worthy = true
            break
          end
        end
      end
    end
    set_job is_worthy
    is_worthy
  end

  def set_job is_worthy
    is_worthy ? value = 'worthy' : value = 'not quite'
    @@db.set(@title, value)
    @@db.expire(@title, 3600) # expire in an hour
  end
end

