module Twix
  module Errors
    class ConfigFileNotFound < RuntimeError
      def message
        ".twixrc not found in #{ENV['HOME']}. Please run 'twix init'"
      end
    end
  end
end
