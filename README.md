# travis-encrypt

Encryption support for models and helpers in travis-ci services.

Usage:

```ruby
require 'travis/encrypt'

Encrypt.setup(key: 'secret')

class Foo < ActiveRecord::Base
  include Travis::Encrypt::Helpers::ActiveRecord

  attr_encrypted :foo
end
```

or:

```ruby
require 'travis/encrypt'

class Foo < ActiveRecord::Base
  include Travis::Encrypt::Helpers::ActiveRecord

  attr_encrypted :foo, key: 'secret'
end
```

For Sequel models use `Travis::Encrypt::Helpers::Sequel`, which also decrypts
values in `values`.

Note this currently goes through normal attribute accessors, so not all methods
might return decrypted values (e.g. ActiveRecord's `pluck`, and Sequel's
`select_map`).

### Doing releases

Bump the version in
[travis/encrypt/version.rb](https://github.com/travis-ci/travis-encrypt/blob/master/lib/travis/encrypt/version.rb),
create a git tag, and push to https://rubygems.org

Or:

```
$ gem install gem-release
$ gem bump --push --tag --release
```
