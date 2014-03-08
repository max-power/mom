require "mongo"
require "mom/version"
require "mom/recipe"
require "mom/file"

module Mom
  module_function
  
  def connect_with(kitchen)
    @kitchen = kitchen
  end

  def db
    @kitchen.db
  end
    
  def oid(id=nil)
    if id.nil?
      BSON::ObjectId.new
    elsif id.is_a?(BSON::ObjectId)
      id
    elsif BSON::ObjectId.legal?(id.to_s)
      BSON::ObjectId.from_string(id.to_s)
    elsif id.to_s.empty?
      nil
    else
      id
    end
  end
end
