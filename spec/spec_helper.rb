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

  create_table :directors_movies, :id => false, :force => true do |t|
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

autoload :Movie, 'support/movie'
autoload :Movies, 'support/movies'
autoload :Character, 'support/character'
autoload :Characters, 'support/characters'
autoload :Director, 'support/director'
autoload :Directors, 'support/directors'
