$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "twix"
require "test/tests_helper"

class ConfigTest < Test::Unit::TestCase
  def setup
    ENV['HOME'] = 'test'
    `rm #{ENV['HOME']}/.twixrc` if File.exist?(ENV['HOME'] + "/.twixrc")
    @config = Twix::Config.instance.data
  end

  def test_create_empty_config_file
    assert_equal(File.exist?(ENV['HOME'] + "/.twixrc"), true)
  end

  def test_load_config_file
    assert_equal(@config[:refresh], 300)
  end
=begin
  def test_update_config_file
    @config[:refresh] = 10
    Twix::Config.update_config_file(@config)

    assert_equal(@config[:refresh], 10)
    assert_equal(YAML.load_file(ENV['HOME'] + "/.twixrc"), @config)

    @config[:refresh] = 7
    Twix::Config.update_config_file(@config)
    assert_equal(@config[:refresh], 7)
  end
=end
=begin
  def test_get_and_update_auth_key
    consumer_key = 'consumer_key_from_user_input'
    STDIN.stubs(:readline).returns(consumer_key)
    config = YAML.load_file(ENV['HOME'] + "/.twixrc")
    default_config = { :consumer_key => nil, 
                       :consumer_secret => nil,
                       :oauth_token => nil,
                       :oauth_token_secret => nil,
                       :refresh => "5"
    }

    assert_equal(default_config, config)
    config = Twix::Config.new
    config.get_key(:consumer_key, "Consumer key:")

    config = YAML.load_file(ENV['HOME'] + "/.twixrc")
    assert_not_equal(default_config, config)
    assert_equal(consumer_key, config[:consumer_key])
  end

  def test_get_consumer_key
    STDIN.stubs(:readline).returns('values_from_user_input')
    config = Twix::Config.new
    config.get_consumer_key()
  end
=end

end
