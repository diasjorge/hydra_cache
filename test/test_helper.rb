require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'construct'
require 'hydra_cache'
require 'typhoeus'

begin require 'ruby-debug'; rescue LoadError; end
