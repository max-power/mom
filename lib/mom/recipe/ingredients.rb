module Mom
  module Ingredients
    def ingredient(name, reader: true, writer: true, store_as: nil)
      attr_reader store_as || name if reader
      attr_writer store_as || name if writer
      alias_method name, store_as  if reader && store_as
      alias_method :"#{name}=", :"#{store_as}=" if writer && store_as
    end
    alias_method :ingr, :ingredient
    
    def ingredients(*names, reader: true, writer: true)
      names.each { |name| ingredient(name, reader: reader, writer: writer) }
    end
  end
end