### 0.2.0 / 2010-11-05

* Added {DataMapper::Resource::State::ReadOnly}:
  * Inherits from the `Clean` state.
  * Raises {DataMapper::ReadOnlyError} exceptions when `set` or `delete`
    are called.
* Fixed a bug where read-only resources with relationships were not being
  loaded.

### 0.1.1 / 2010-08-11

* Override `saved?` in `DataMapper::Resource` to always return `true`,
  so that methods such as `save_self` will also return `true`. This allows
  read-only models to be used in relationships with non-read-only models.

### 0.1.0 / 2010-06-08

* Initial release.
  * Ignores auto-migrations on read-only Models.
  * Ignores auto-upgrades on read-only Models.
  * Puts all resources of a read-only Model into the Immutable state.
  * Supports the `:migrations` and `:mutable` options for selectively enabling
    migrations or mutability.

