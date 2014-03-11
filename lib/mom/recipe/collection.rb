require "forwardable"

module Mom
  module Collection
    extend Forwardable
    
    def_delegators :collection, :count, :size, :distinct, :map_reduce, :group, :aggregate, :stats
    def_delegators :collection, :save, :insert, :upsert, :update, :find_and_modify, :remove 
    def_delegators :collection, :ensure_index, :create_index, :drop_index, :drop_indexes, :index_information
    
    def collection_name
      if superclass == Mom::Recipe || superclass == Mom::File
        @_collection_name || name.gsub('::', '.').downcase + 's' # model_name.plural
      else
        superclass.collection_name
      end
    end
    
    def collection_name=(value)
      @_collection_name = value.to_s
    end

    def collection
      @_collection ||= Mom.db[collection_name]
    end
    
    def collection=(value)
      @_collection = value if value.is_a? Mongo::Collection
    end

    def find_one(selector_or_id=nil, options={})
      collection.find_one selector_or_id, query_options(options)
    end
  
    def find(selector={}, options={})
      collection.find selector, query_options(options)
    end

    def create(ingredients={})
      new(ingredients).tap { |recipe| recipe.save }
    end

    def query_options(extra={})
      { transformer: transformer }.merge(extra)
    end
    
    def transformer
      -> doc { new(doc) }
    end
  
    alias_method :all, :find
    alias_method :first, :find_one
    alias_method :delete_all, :remove
  end
end