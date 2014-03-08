# MOM

A lightweight Mongo Object Mapper. Very alpha!!!

## Installation

Add this line to your application's Gemfile:

    gem 'mom'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mom

## Usage

    require "mom"
    
    Mom.connect_with Mongo::MongoClient.new
    
    class Location < Mom::Snippet
      attr_accessor :lat, :lng
    end
    
    class User < Mom::Recipe
      attr_accessor :name, :location
      
      def location=(value)
        @location = Location.new(value)
      end
    end
    
    user = User.create(name: 'Georg', location: { lat: 213.3212, lng: 43.234224 })
    user.name = "Georg I."
    user.save
    
    
## Contributing

1. Fork it ( http://github.com/<my-github-username>/mom/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
