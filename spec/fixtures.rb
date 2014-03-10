require 'uri'
require 'pathname'

class User < Mom::Recipe
  class Token < Mom::Snippet
    ingr :provider, store_as: :p
    ingr :uid, store_as: :u
  end

  ingredients :name, :email, :nickname, :image
  ingredient :auth, default: []
  
  def auth=(value)
    self[:auth] = Array(value).map { |t| Token.new(t) }
  end
  
  def image=(value)
    self[:image] = URI(value.to_s) if value
  end
end

class Asset < Mom::File
  ingredient :custom_thing
end

require "mom/helper/nesting"
class Event < Mom::Recipe
  include Mom::Nesting
  
  ingredient :name
end
