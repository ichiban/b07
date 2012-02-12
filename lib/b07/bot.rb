module B07
  class Bot
    include Redis::Objects

    attr_reader :id

    value :consumer_key
    value :consumer_secret
    value :oauth_token
    value :oauth_token_secret
    
    def initialize(id, host='127.0.0.1', port=6379)
      @id = id
      redis = Redis.new(:host => host, :port => port)
      @mecab = Natto::MeCab.new

      Twitter.configure do |c|
        c.consumer_key = consumer_key
        c.consumer_secret = consumer_secret
        c.oauth_token = oauth_token
        c.oauth_token_secret = oauth_token_secret
      end
    end

    def learn(text)
      one = two = three = nil

      @mecab.parse(text) do |n|
        three = n.surface
        
        Occurrence.new(self, one, two).words << three
        
        one = two
        two = three
      end
      
      return unless two || three
      
      Occurrence.new(self, two, three).words << nil
    end

    def load(file)
      open(file) do |io|
        io.readlines.each do |line|
          learn line
        end
      end
    end

    def forget
      Occurrence.delete(self)
    end

    def tweet(text)
      client = Twitter::Client.new
      client.update text
    end

    def random(dry=false, tag=nil)
      text = ''
      word, occur = Occurrence.new(self, nil, nil).subseq
      length = 140

      if tag
        tag = " ##{tag}"
        length - tag.length
      end

      until word.nil? || text.size >= length
        text << word
        word, occur = occur.subseq
      end

      text << tag if tag

      if dry
        puts text
      else
        tweet text
      end
    end
  end
end
