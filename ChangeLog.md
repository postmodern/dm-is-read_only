### 0.1.0 / 2010-06-08

* Initial release.
  * Ignores auto-migrations on read-only Models.
  * Ignores auto-upgrades on read-only Models.
  * Puts all resources of a read-only Model into the Immutable state.
  * Supports the `:migrations` and `:mutable` options for selectively enabling
    migrations or mutability.

