require "mime/types"
require_relative "recipe/grid"

module Mom
  class File < Recipe
    extend Grid
    extend Forwardable
    def_delegators :io, :read, :rewind, :client_md5, :file_length, :file_position, :files_id, :server_md5
    
    ingredient :filename
    ingredient :metadata
    ingredient :content_type, store_as: :contentType
    ingredient :size,         store_as: :length,     writer: false
    ingredient :chunk_size,   store_as: :chunkSize,  writer: false
    ingredient :uploaded_at,  store_as: :uploadDate, writer: false
    ingredient :md5, writer: false

    def io
      @__io ||= self.class.grid.get(id)
    end
  end
end