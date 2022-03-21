require 'test_helper'

class DummyTestClass
  include PrettyDate
end

class PrettyDateTest < ActiveSupport::TestCase
  test '#apollo_date when short iso date passed in' do
    assert_equal '01-28-2022, 00:00 AM', DummyTestClass.new.apollo_date('2022-01-28')
  end

  test '#apollo_date when long iso date passed in' do
    assert_equal '01-24-2022, 00:00 AM', DummyTestClass.new.apollo_date('2022-01-24T10:10:15-08:00')
  end

  test '#apollo_date3 when long iso date passed in' do
    assert_equal 'January 24, 2022', DummyTestClass.new.apollo_date3('2022-01-24T10:10:15-08:00')
  end

  test '#apollo_date garbage in garbage out' do
    assert_equal 'garbage', DummyTestClass.new.apollo_date('garbage')
  end

  test '#apollo_date2 garbage in garbage out' do
    assert_equal 'garbage', DummyTestClass.new.apollo_date2('garbage')
  end

  test '#apollo_date3 garbage in garbage out' do
    assert_equal 'garbage', DummyTestClass.new.apollo_date3('garbage')
  end

  test '#apollo_date4 garbage in garbage out' do
    assert_equal 'garbage', DummyTestClass.new.apollo_date4('garbage')
  end
end
