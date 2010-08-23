module Twix
  class Client
    def initialize
      trap_signals
      @config = Twix::Config.instance.data
      if @config[:consumer_token] && @config[:consumer_secret]
        @oauth = Twix::OAuth.instance
        link! if !linked?
      end
    end
    
    def trap_signals
      trap('INT') { puts "\rExiting..."; exit(0); }
    end

    def feed
      if linked?
        feeds_thread = fetch()        
        while key = STDIN.readline.chomp
          case key
          when 'q'
            feeds_thread.kill
            exit
          when 't'
            feeds_thread.kill
            system('clear')
            break
          end
        end
        twit()
      end
    end

    def fetch
      Thread.new do
        len = @config[:twits_no]
        refresh = @config[:refresh]
        last = ""
        print("Fetching twits...\n")

        loop do 
          begin
            res = @oauth.access_token(@oauth.token_hash).request(
              :get, "http://api.twitter.com/1/statuses/home_timeline.json"
            )
            twits = JSON.parse(res.body)
            latest = twits.first

            if last != latest['id']
              last = latest['id']
              system('clear')
              twits[0...len].each do |twit|
                print("\e[32m#{twit['user']['name']} wrote:\n")
                print("\e[37m" + twit['text'] + "\n")
                print "------------------------------------------------\n"
              end
            end

            sleep refresh
          rescue
          end
        end
      end
    end

    def twit
      Twix::Twit.new()
      feed()
    end

    def linked?
      !@config[:oauth_token].nil? and !@config[:oauth_token_secret].nil?
    end

    private

    def link!
      if !@config[:pin]
        print("Please go to #{@oauth.authorize_url} and enter PIN number\n")
        print("PIN:")
        pin = STDIN.readline.chomp 
        @config[:pin] = pin
      end

      tokens = @oauth.access_tokens(@config[:pin])
      @config[:oauth_token] = tokens.token
      @config[:oauth_token_secret] = tokens.secret
      Twix::Config.instance.update_config_file()
    end
  end
end
