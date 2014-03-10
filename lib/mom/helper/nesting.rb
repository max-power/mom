module Mom
  module Nesting
    def self.included(base)
      base.extend ClassMethods
      base.ingredient :parent_id,  store_as: :_parent_id
      base.ingredient :parent_ids, store_as: :_parent_ids, default: -> doc { [doc.parent_id].compact }
    end

    module ClassMethods
      def roots
        find(_parent_id: nil)
      end
    end
    
    def parent
      self.class.find_one(_id: parent_id) if parent_id
    end
    
    def parent=(model)
      self.parent_id  = model.id
      self.parent_ids = model.parent_ids + [model.id]
    end

    def ancestors
      self.class.find(_id: { "$in" => parent_ids }) if parent_ids
    end
    
    def children
      self.class.find(_parent_id: id ) if persisted?
    end
    
    def siblings_and_self
      self.class.find(_parent_id: parent_id) if persisted?
    end
    
    def siblings
      self.class.find(_parent_id: parent_id, _id: {"$ne" => id}) if persisted?
    end
    
    def descendants
      self.class.find(_parent_ids: id ) if persisted?
    end
    
    def root_id
      parent_ids.first || id
    end
    
    def root?
      root_id == id
    end
    
    def root
      root? ? self.class.find_one(_id: root_id) : self
    end
  end
end