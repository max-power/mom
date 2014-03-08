require 'uri'
require 'pathname'

class User < Mom::Recipe
  class Token < Mom::Snippet
    ingr :provider, store_as: :p
    ingr :uid, store_as: :u
  end

  ingredients :name, :email, :nickname, :auth, :image
  
  def auth=(value)
    @auth = Array(value).map { |t| Token.new(t) }
  end
  
  def image=(value)
    @image = URI(value.to_s) if value
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
