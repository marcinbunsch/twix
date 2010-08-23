module Twix
  class Twit
    LIMIT = 140

    def initialize
      @config = Twix::Config.instance.data
      @oauth = Twix::OAuth.instance
      print("Enter you message here (max length #{LIMIT}). To send your message, type !SEND.\n")
      @body = ""
      while data = STDIN.readline.chomp
        @body += data
        find_command()
        eval(@break) if @break
      end
    end

    private

    def find_command
      if @body =~ /!SEND/
        @body.gsub!('!SEND', '')
        @break = 'break'
        validate()
        send()
      elsif @body =~ /!EXIT/
        @body.gsub!('!EXIT', '')
        @break = 'break'
        quit()
      end
    end

    def validate
      @action = 'quit' if @body.length == 0
      if @body.length > LIMIT
        @body = @body[0...LIMIT]
        @message = "Twit length exceeded, truncating..."
      end
    end

    def send
      print("\e[31m#{@message}\e[0m\n") if @message
      print("sending...\n")
      @oauth.access_token(@oauth.token_hash).request(
        :post,"http://api.twitter.com/1/statuses/update.json", {:status => @body}
      )

      print("\e[32mYour twit has been sent\e[0m\n")
      sleep 1
      system("clear")
    end

    def quit
      print("\e[32mCanceled\e[0m\n")
      sleep 1
      system("clear")
    end

  end
end
