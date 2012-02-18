# dm-is-read_only

* [Source](http://github.com/postmodern/dm-is-read_only)
* [Issues](http://github.com/postmodern/dm-is-read_only/issues)
* [Documentation](http://rubydoc.info/gems/dm-is-read_only/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

A DataMapper plugin for making Models absolutely **read-only**.

## Features

* Ignores auto-migrations on read-only Models.
* Ignores auto-upgrades on read-only Models.
* Puts all resources of a read-only Model into the Immutable state.
* Supports the `:migrations` and `:mutable` options for selectively enabling
  migrations or mutability.

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
  
    Licence.first
    # => #<Licence: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

    # ignores auto-migrations
    License.auto_migrate!
    # => true

    Licence.first
    # => #<Licence: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

    # ignores auto-upgrades
    License.auto_upgrade!
    # => true

    license = Licence.first
    # => #<Licence: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

    license.name = 'WTF'
    license.save!
    # => true

    # will not allow saving resources
    license.reload
    license.name
    # => "GPL-2"

    license.destroy!
    # => true

    # will not allow destroying resources
    license = License.first
    # => #<Licence: id: 1, name: "GPL-2", url: "http://www.gnu.org/copyleft/gpl.html">

## Requirements

* [dm-core](http://github.com/datamapper/dm-core/) ~> 1.2

## Install

    $ sudo gem install dm-is-read_only

## License

Copyright (c) 2010-2012 Hal Brodigan

See {file:LICENSE.txt} for license information.
