$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rails/all'
require 'rspec/rails'
require 'herd'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

RSpec.configure do |config|
  config.color_enabled = true
  config.use_transactional_fixtures = true
end

ActiveRecord::Schema.define(:version => 1) do
  create_table :directors, :force => true do |t|
    t.string :name
  end

  create_table :directors_movies, :force => true do |t|
    t.integer :director_id
    t.integer :movie_id
  end

  create_table :movies, :force => true do |t|
    t.string :name
    t.integer :revenue
  end

  create_table :characters, :force => true do |t|
    t.string :name
    t.integer :movie_id
  end
end

class Movie < ActiveRecord::Base
  has_and_belongs_to_many :directors
  has_many :characters, :dependent => :destroy
end

class Movies < Herd::Base
  model Movie

  scope :failures, where("revenue < '10000000'")

  def self.directed_by(director)
    where(directors: {name: director}).joins(:directors)
  end
end

class Character < ActiveRecord::Base
  belongs_to :movie
end

class Characters < Herd::Base
  model Character

  scope :fat, where(name: 'chunk')
end

class Director < ActiveRecord::Base
  has_and_belongs_to_many :movies
end

class Directors < Herd::Base
end
