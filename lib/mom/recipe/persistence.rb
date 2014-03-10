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
      self.id = self.class.save(to_mongo)
      true
    rescue Mongo::OperationFailure => e
      false
    end

    def update(ingredients)
      result = self.class.update({ _id: id }, { "$set" => ingredients })
      result["n"] > 0
    end
    
    def destroy
      if persisted?
        result  = self.class.remove({_id: id})
        deleted = result["n"] > 0
      end
      ingredients.delete(:_id) if deleted
      !!deleted
    end
    
    def reload
      load self.class.collection.find_one(id) if persisted?
      self
    end
  end
end