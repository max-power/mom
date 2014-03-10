module Mom
  module Grid
    def grid
      @_grid ||= Mongo::Grid.new(Mom.db, collection_name)
    end
    
    def collection
      grid.instance_variable_get :@files
    end
    
    def create(file, ingredients={})
      find_one grid.put(file, new(ingredients).to_mongo)
    end
    
    def remove(selector)
      id = selector[:_id]
      grid.delete(id) if id
    end
  end
end