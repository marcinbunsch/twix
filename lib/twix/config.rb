module Twix
  class Config
    include Singleton

    CONFIG_PATH = ENV['HOME'] + "/.twixrc"
    attr_accessor :data

    def initialize
      create_config_file() if !File.exist?(CONFIG_PATH)
      load_config()
    end

    def update_config_file(config=@data)
      File.open(CONFIG_PATH, 'w') do |f| 
        YAML.dump(config, f)
      end
    end
  
    private

    def create_config_file
      config = { :consumer_token => 'QNqHgD2InhYH9xwYcyhvNw', 
                 :consumer_secret => 'hpcT1b2QJfO0HOlEh5AuWI4xRAZYnYWzGFWXj7u72k',
                 :oauth_token => nil,
                 :oauth_token_secret => nil,
                 :pin => nil,
                 :refresh => 300,
                 :twits_no => 15
      }
      update_config_file(config)
    end

    def load_config
      @data = YAML.load_file(CONFIG_PATH)
    end
  end
end
