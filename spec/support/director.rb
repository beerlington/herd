class Director < ActiveRecord::Base
  herded_by Directors
  has_and_belongs_to_many :movies
end
