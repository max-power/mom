module Mom
  class Serializer
    def self.for(klass)
      Serializers[klass.name.to_sym]
    end
    
    def initialize(value)
      @value = value
    end
    
    def to_mongo
      @value.respond_to?(:to_mongo) ? @value.to_mongo : @value
    end
    
    protected
    
    def mongoize(value)
      self.class.for(value.class).new(value).to_mongo
    end
  end
  
  class NullSerializer < Serializer
  end
  
  class StringSerializer < Serializer
    def to_mongo
      super.to_s
    end
  end

  class ArraySerializer < Serializer
    def to_mongo
      super.map { |value| mongoize(value) }
    end
  end

  class HashSerializer < Serializer
    def to_mongo
      super.each_with_object({}) do |(k,v),h|
        h[StringSerializer.new(k).to_mongo] = mongoize(v)
      end
    end
  end
  
  Serializers = {
    Array: ArraySerializer,
    Hash:  HashSerializer,
    URI:   StringSerializer,
    Pathname: StringSerializer
  }
  Serializers.default = NullSerializer
end