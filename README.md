# Herd

Organize ActiveRecord collection functionality into separate classes

## Installation

Add this line to your application's Gemfile:

    gem 'herd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install herd

## Usage

```ruby
class Movie < ActiveRecord::Base
  has_and_belongs_to_many :directors
  has_many :characters, :dependent => :destroy
end

class Movies < Herd::Base
  model Movie

  scope :failures, where("revenue < '10000000'")

  def self.directed_by(director)
    where('director = ?', director)
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
