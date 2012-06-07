# Herd

Organize ActiveRecord collection functionality into manageable classes.

## Requirements

* Ruby >= 1.9.2
* Rails >= 3.0.0

## What is Herd?

As models grow in size and complexity, it can be challenging to keep
track of which class methods are for collections and which are not.
Throw validations, associations, and scopes into the mix, and the model
can become unwieldy to manage.

Herd provides a way to organize collection related functionality into
separate, manageable classes.

Take the following ActiveRecord class for example:

```ruby
class Movie < ActiveRecord::Base
  scope :recent, where('released_at > ?', 6.months.ago)
  scope :profitable, where('gross > budget')

  def self.filter_by_title(title)
    where('title LIKE ?', "%#{title}%")
  end

  def release_year
    released_at.year
  end

  def profitable?
    gross > budget
  end
end
```

Using Herd, you can define a separate class to declare collection concerns:

```ruby
class Movie < ActiveRecord::Base
  def release_year
    released_at.year
  end

  def profitable?
    gross > budget
  end
end

class Movies < Herd::Base
  scope :recent, where('released_at > ?', 6.months.ago)
  scope :profitable, where('gross > budget')

  def self.filter_by_title(title)
    where('title LIKE ?', "%#{title}%")
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'herd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install herd

You also need to preload all the Herd collections. The simplest way to
do this is to add a Rails initializer with the following:

config/initializers/herd.rb

```ruby
Herd.load_collections
```

## Usage Example

Using Herd is as easy as inheriting from `Herd::Base`. Declaring the
model is optional if it can be inferred by the ActiveRecord class
name.

```ruby
class Movie < ActiveRecord::Base
  has_and_belongs_to_many :directors
  has_many :characters, :dependent => :destroy
end

class Movies < Herd::Base
  # Optional
  model Movie

  scope :failures, where("revenue < '10000000'")

  def self.directed_by(director)
    where(directors: {name: director}).joins(:directors)
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
