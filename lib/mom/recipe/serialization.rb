require "json"
require "mom/serializers/all"

module Mom
  module Serialization
    def to_h
      instance_variables.each_with_object({}) do |name, ingredients|
        ingredients[name[1..-1].to_sym] = instance_variable_get(name)
      end
    end
    
    def to_mongo
      to_h.reject { |k,v| k.to_s.start_with?("__") }
    end
    
    def as_mongo_hash
      #Mom::Serializer.serialize(to_mongo)
      Mom::HashSerializer.new(to_mongo).to_mongo
    end
    
    def to_json
      as_mongo_hash.to_json
    end
  end
end
