module Mom
  module Ingredients
    def ingredient(name, reader: true, writer: true, store_as: name, default: nil)
      create_ingredient_reader(name, store_as, default) if reader
      create_ingredient_writer(name, store_as) if writer
    end
    alias_method :ingr, :ingredient
    
    def ingredients(*names, reader: true, writer: true)
      names.each { |name| ingredient(name, reader: reader, writer: writer) }
    end
    
    private
    
    def create_ingredient_reader(name, mongo_name, default)
      define_method(name) { get_ingredient(mongo_name, default) }
    end
    
    def create_ingredient_writer(name, mongo_name)
      define_method(:"#{name}=") { |val| set_ingredient(mongo_name, val) }
    end
  end
end