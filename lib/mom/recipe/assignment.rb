module Mom
  module Assignment
    def initialize(ingredients={})
      load ingredients if ingredients.is_a? Hash
    end
    
    def load(ingredients)
      ingredients.each { |k,v| set_ingredient(k,v) }
    end
    
    def get_ingredient(ingr)
      respond_to?(ingr) ? public_send(ingr) : instance_variable_get(:"@#{ingr}")
    end
  
    def set_ingredient(ingr, value)
      if respond_to?(:"#{ingr}=")
        public_send(:"#{ingr}=", value)
      else
        instance_variable_set(:"@#{ingr}", value)
      end
    end
    
    def ingredients
      @__ingredients ||= {}
    end

    alias_method :[],  :get_ingredient
    alias_method :[]=, :set_ingredient
  end
end