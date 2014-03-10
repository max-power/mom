module Mom
  module Assignment
    def initialize(ingredients={})
      load ingredients if ingredients.is_a? Hash
    end
    
    def load(ingredients)
      ingredients.each { |k,v| write_ingredient(k,v) }
    end
    
    def read_ingredient(ingr)
      respond_to?(ingr) ? public_send(ingr) : instance_variable_get(:"@#{ingr}")
    end
  
    def write_ingredient(ingr, value)
      if respond_to?(:"#{ingr}=")
        public_send(:"#{ingr}=", value)
      else
        instance_variable_set(:"@#{ingr}", value)
      end
    end

    alias_method :[],  :read_ingredient
    alias_method :[]=, :write_ingredient
  end
end