module Mom
  module Comparison
    def eql?(other)
      self.class == other.class && self.id == other.id
    end
    alias :== :eql?

    def hash
      to_mongo.hash
    end
  end
end