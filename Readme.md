This is a gem to provide caching for typhoeus that works with Test Unit

## Installation

Simply install with:

    gem install hydra_cache

## Basic usage

You need to configure your hydra instance:

    hydra.cache_setter &HydraCache.method(:setter)
    hydra.cache_getter &HydraCache.method(:getter)

There is a parameter called revision. This parameter is useful to generate unique identifier for your requests, so when you change the revision the fixtures would get regenerated.

You may as well configure the path for your fixture files. Put something like this in your test helper.

    HydraCache.fixtures_path = 'test/fixtures'

## Prefixes

Prefixes allow you to configure a sub-directory where to put your fixtures, Eg.

    class Test
      def setup
        HydraCache.prefix = 'Something'
      end

      def teardown
        HydraCache.prefix = nil # Reset the original value
      end
    end
