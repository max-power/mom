# -*- encoding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/spec'

require 'mom'


class Document < Mom::Recipe
  attr_accessor :title, :list, :url, :path
end

class Embedded < Mom::Snippet
  attr_accessor :one, :two
end