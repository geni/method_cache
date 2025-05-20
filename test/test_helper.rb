require 'rubygems'
require 'dalli'
require 'minitest/autorun'
require 'minitest/unit'
require 'shoulda'
require 'pp'

unless defined?($SKIP_COVERAGE)
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
    add_filter 'vendor'
  end
end

require 'method_cache'

PORT = 19112
MethodCache.pool[:default] = MethodCache.default_cache
MethodCache.pool[:remote]  = Dalli::Client.new("localhost:#{PORT}")

class Object
  def tap_pp(*args)
    pp [*args, self]
    self
  end
end

class MiniTest::Test

  def start_memcache(port=PORT)
    return if File.exist?("/tmp/memcached_#{port}.pid")

    system("memcached -p #{port} -U 0 -d -P /tmp/memcached_#{port}.pid")
    sleep 1

    at_exit do
      system("kill -9 `cat /tmp/memcached_#{port}.pid`")
      File.delete("/tmp/memcached_#{port}.pid")
    end

    File.read("/tmp/memcached_#{port}.pid")
  end

end