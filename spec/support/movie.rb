class Movie < ActiveRecord::Base
  herded_by Movies

  has_and_belongs_to_many :directors
  has_many :characters, :dependent => :destroy
end
