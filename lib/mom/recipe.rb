require_relative "recipe/ingredients"
require_relative "recipe/mass_assignment"
require_relative "recipe/serialization"
require_relative "recipe/collection"
require_relative "recipe/persistence"
require_relative "recipe/comparison"

module Mom
  class Snippet
    extend Ingredients
    include MassAssignment
    include Serialization
  end
  
  class Recipe < Snippet
    extend Collection
    include Persistence
    include Comparison
  end
end