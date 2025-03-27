require File.dirname(__FILE__) + '/test_helper'

class FooBar
  extend MethodCache

  attr_accessor :foo_called, :foo_count_called

  def method_cache_key
    object_id
  end

  cache_method :foo, :cache => :remote, :expiry => 1
  def foo
    @foo_called ||= 0
    @foo_called += 1
    'bar'
  end

  cache_method :foo_count, :counter => true, :cache => :remote, :expiry => 1
  def foo_count
    @foo_count_called ||= 0
    @foo_count_called  += 1
    100
  end

end

class MethodCacheRemoteTest < MiniTest::Test

  should 'not call a cached method twice' do
    start_memcache

    f = FooBar.new
    assert_equal 'bar', f.foo
    assert_equal 'bar', f.foo
    assert_equal     1, f.foo_called
  end

  should 'expire cached method' do
    start_memcache

    f = FooBar.new
    assert_equal 'bar', f.foo
    assert_equal 'bar', f.foo
    assert_equal     1, f.foo_called

    sleep 2
    assert_equal 'bar', f.foo
    assert_equal     2, f.foo_called
  end


  should 'not call a cached counter method twice' do
    start_memcache

    f = FooBar.new
    assert_equal 100, f.foo_count
    assert_equal 100, f.foo_count
    assert_equal   1, f.foo_count_called

    f.increment_foo_count(:by => 42)
    assert_equal 142, f.foo_count
    assert_equal   1, f.foo_count_called
  end

  should 'expire cached counter method' do
    start_memcache

    f = FooBar.new
    assert_equal 100, f.foo_count
    assert_equal 100, f.foo_count
    assert_equal   1, f.foo_count_called

    f.increment_foo_count(:by => 42)
    assert_equal 142, f.foo_count
    sleep 2

    assert_equal 100, f.foo_count
    assert_equal   2, f.foo_count_called
  end


end
