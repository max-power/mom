module Mom
  module Assignment
    def initialize(ingredients={})
      load ingredients if ingredients.is_a? Hash
    end
    
    def load(ingredients)
      ingredients.each do |k,v|
        respond_to?(:"#{k}=") ? public_send(:"#{k}=", v) : set_ingredient(k,v)
      end
    end
    
    def get_ingredient(ingr, default=nil)
      ingredients.fetch(ingr.to_sym) do
        default.respond_to?(:call) ? default.call(self) : default
      end
    end
  
    def set_ingredient(ingr, value)
      ingredients.store(ingr.to_sym, value)
    end

    alias_method :[],  :get_ingredient
    alias_method :[]=, :set_ingredient
    
    def ingredients
      @_ingredients ||= {}
    end
  end
end
