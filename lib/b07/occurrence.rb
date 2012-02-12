
module B07
  class Occurrence
    include Redis::Objects

    attr_reader :id
    attr :prec
    list :words

    def initialize(bot, *words)
      @bot = bot
      @prec = words
      @id = [bot.id, words.join(' ')].join('/')
    end

    def self.delete(bot)
      prefix = self.name.downcase.gsub(/(.*::)?([^:]+)$/, '\2')
      redis.keys("#{prefix}:#{bot.id}/*").each do |key|
        redis.del key
      end
    end
    
    def subseq
      word = words[rand(words.length)]
      args = prec.clone
      args.shift
      args.push word
      [word, self.class.new(@bot, *args)]
    end
  end
end
