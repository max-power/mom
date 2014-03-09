module Mom
  module Persistence
    def self.included(base)
      base.ingredient :id, store_as: :_id
    end

    def persisted?
      !id.nil?
    end
    
    def created_at
      id.generation_time if id.is_a?(BSON::ObjectId)
    end
    
    def save(*)
      self.id = self.class.save(as_mongo_hash)
      true
    rescue Mongo::OperationFailure => e
      false      
    end
    
    def destroy
      if persisted?
        result  = self.class.remove({_id: _id})
        deleted = result["n"] > 0
      end      
      remove_instance_variable(:@_id) if deleted
      !!deleted
    end
    
    def reload
      load self.class.collection.find_one(id) if persisted?
      self
    end
  end
end