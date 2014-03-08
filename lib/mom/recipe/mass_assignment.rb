module Mom
  module MassAssignment
    def initialize(ingredients={})
      load ingredients if ingredients.is_a? Hash
    end
    
    def load(ingredients)
      ingredients.each do |name, value| 
        if respond_to?(:"#{name}=")
          public_send(:"#{name}=", value)
        else
          instance_variable_set(:"@#{name}", value)
        end
      end
    end
  end
end