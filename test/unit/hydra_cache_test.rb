require 'test_helper'

describe HydraCache do
  include Construct::Helpers

  after { HydraCache.fixtures_path = nil }

  let(:hydra) do
    hydra = Typhoeus::Hydra.new
    hydra.cache_setter &HydraCache.method(:setter)
    hydra.cache_getter &HydraCache.method(:getter)
    hydra
  end

  it 'should create a fixture file after the hit' do
    r = Typhoeus::Request.new("http://example.com")
    hydra.queue r

    within_construct do |c|
      HydraCache.fixtures_path = Dir.pwd
      Dir["*.yml"].must_be_empty
      hydra.run
      Dir["*.yml"].wont_be_empty
    end
  end

  it 'should handle different order of uri query' do
    r1 = Typhoeus::Request.new("http://example.com?p1=1&p2=2")
    hydra.queue r1
    r2 = Typhoeus::Request.new("http://example.com?p2=2&p1=1")
    hydra.queue r2

    within_construct do |c|
      HydraCache.fixtures_path = Dir.pwd
      hydra.run
      Dir["*.yml"].size.must_equal 1
    end
  end

  it 'should handle different order of params' do
    r1 = Typhoeus::Request.new("http://example.com", :params => {"p1" => 1, "p2" => 2})
    hydra.queue r1
    r2 = Typhoeus::Request.new("http://example.com", :params => {"p2" => 2, "p1" => 1})
    hydra.queue r2

    within_construct do |c|
      HydraCache.fixtures_path = Dir.pwd
      hydra.run
      Dir["*.yml"].size.must_equal 1
    end
  end

  it 'should handle different order of body' do
    r1 = Typhoeus::Request.new("http://example.com", :body => "foo=bar\nbaz=wadus", :method => :post)
    hydra.queue r1
    r2 = Typhoeus::Request.new("http://example.com", :body => "baz=wadus\nfoo=bar", :method => :post)
    hydra.queue r2

    within_construct do |c|
      HydraCache.fixtures_path = Dir.pwd
      hydra.run
      Dir["*.yml"].size.must_equal 1
    end
  end

  it 'should handle different methods for same url' do
    r1 = Typhoeus::Request.new("http://example.com")
    hydra.queue r1
    r2 = Typhoeus::Request.new("http://example.com", :method => :post)
    hydra.queue r2

    within_construct do |c|
      HydraCache.fixtures_path = Dir.pwd
      Dir["*.yml"].must_be_empty
      hydra.run
      Dir["*.yml"].size.must_equal 2
    end
  end
end
