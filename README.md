# dm-is-read_only

* [github.com/postmodern/dm-is-read_only](http://github.com/postmodern/dm-is-read_only)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

A DataMapper plugin for making Models absolutely **read-only**.

## Example

    require 'dm-core'
    require 'dm-is-read_only'
  
    class Licence
  
      include DataMapper::Resource

      is :read_only

      # The primary-key of the License
      property :id, Serial
    
      # Name of the Licence
      property :name, String
    
      # URL to the licence
      property :url, String
    
    end
  
## Requirements

* [dm-core](http://github.com/datamapper/dm-core/) >= 0.10.2

## Install

    $ sudo gem install dm-is-read_only

## License

See {file:LICENSE.txt} for license information.

