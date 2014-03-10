require "json"
require "mom/serializers/all"

module Mom
  module Serialization
    def to_h
      ingredients
    end
    
    def to_mongo
      Mom::HashSerializer.new(to_h).to_mongo
    end
    
    def to_json
      to_mongo.to_json
    end
  end
end
