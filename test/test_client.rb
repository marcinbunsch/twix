$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "twix"
require "test/tests_helper"

class ClientTest < Test::Unit::TestCase
  def setup
    ENV['HOME'] = 'test'
    `rm -f test/.twixrc`
  end

  def test_linked_with_twitter
    client = Twix::Client.new
    client.config.values[:oauth_token] = "someOAuthToken"
    client.config.values[:oauth_secret] = "someOAuthSecret"

    assert_equal(client.linked?, true)
  end

  def test_not_linked_with_twitter
    client = Twix::Client.new
    assert_equal(client.linked?, false)
  end

  def test_get_pin
    Twix::OAuth.any_instance.stubs(:authorize_url).returns("twitter.com/abc")
    STDIN.stubs(:readline).returns('123456789')

    client = Twix::Client.new
    assert_equal(client.config.values[:pin], nil)

    client.get_pin
    assert_equal(client.config.values[:pin], '123456789')

    config_file = YAML.load_file(ENV['HOME'] + "/.twixrc")
    assert_equal(config_file[:pin], '123456789')
  end

  

end
