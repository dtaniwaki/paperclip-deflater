# paperclip-deflater

[![Gem Version][gem-image]][gem-link]
[![Dependency Status][deps-image]][deps-link]
[![Build Status][build-image]][build-link]
[![Coverage Status][cov-image]][cov-link]
[![Code Climate][gpa-image]][gpa-link]

Deflate files in Paperclip before upload.

## Installation

Add the paperclip-deflater gem to your Gemfile.

```ruby
gem "paperclip-deflater"
```

And run `bundle install`.

## Setup

```ruby
class Something < ActiveRecord::Base
  has_attached_file :js,
    styles: {
      gzip: {
        processors: [:gzip],
        format: 'js.gz',
        s3_headers: { content_type: 'application/javascript', content_encoding: 'gzip' },
      }
    },
    path: "test/:id.:extension"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.




[gem-image]:   https://badge.fury.io/rb/paperclip-deflater.svg
[gem-link]:    http://badge.fury.io/rb/paperclip-deflater
[build-image]: https://secure.travis-ci.org/dtaniwaki/paperclip-deflater.png
[build-link]:  http://travis-ci.org/dtaniwaki/paperclip-deflater
[deps-image]:  https://gemnasium.com/dtaniwaki/paperclip-deflater.svg
[deps-link]:   https://gemnasium.com/dtaniwaki/paperclip-deflater
[cov-image]:   https://coveralls.io/repos/dtaniwaki/paperclip-deflater/badge.png
[cov-link]:    https://coveralls.io/r/dtaniwaki/paperclip-deflater
[gpa-image]:   https://codeclimate.com/github/dtaniwaki/paperclip-deflater.png
[gpa-link]:    https://codeclimate.com/github/dtaniwaki/paperclip-deflater

