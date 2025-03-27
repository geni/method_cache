require 'rubygems'
require 'dalli'
require 'minitest/autorun'
require 'minitest/unit'
require 'shoulda'
require 'pp'

require 'method_cache'

PORT = 19112
MethodCache.pool[:default] = MethodCache.default_cache
MethodCache.pool[:remote]  = Dalli::Client.new("localhost:#{PORT}")

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