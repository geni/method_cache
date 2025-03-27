require File.dirname(__FILE__) + '/test_helper'

class FooBar
  extend MethodCache

  cache_method :foo, :cache => $client 
  def foo
    'bar'
  end
end

class MethodCacheRemoteTest < MiniTest::Test

  should 'work with dalli client' do
    start_memcache

    f = FooBar.new
    assert_equal 'bar', f.foo
  end
end
