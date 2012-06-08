class Character < ActiveRecord::Base
  herded_by Characters
  belongs_to :movie
end
