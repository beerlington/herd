require "herd/version"

module Herd

  class Base
    # Specify the model class that the collection contains
    # @param [Class] model the class that the collection contains
    #
    # @example
    #  # Herd collection
    #  class Movies < Herd::Base
    #    model Movie
    #  end
    def self.model(model)
      @model_class = model
    end

    # Add all class methods to the model class so that these methods are
    # available to ActiveRecord::Relation etc
    def self.inherited(klass)
      klass.class_eval do
        def self.singleton_method_added(method_name)
          return if @model_class.nil?

          method = self.method(method_name).to_proc
          @model_class.define_singleton_method(method_name, method)
        end

        # Set the model class name
        begin
          @model_class = name.singularize.constantize
        rescue NameError
        end
      end
    end

    # Delegate all methods to the model class if you want to do something like:
    # Collection.find_by_name('blah')
    def self.method_missing(method, *args, &block)
      if @model_class.respond_to?(method)
        @model_class.send(method, *args, &block)
      else
        super
      end
    end
  end

  module ActiveRecord
    # Specify the Herd collection class that the model is a member of
    # @param [Class] herd_collection the Herd class that the model is a member of
    #
    # @example
    #  # ActiveRecord model
    #  class Movie < ActiveRecord::Base
    #    herded_by Movies
    #  end
    def herded_by(herd_collection)
      raise ArgumentError, 'collection must inherit from Herd::Base' unless herd_collection.ancestors.include? Herd::Base

      herd_collection
    end
  end
end

ActiveRecord::Base.extend Herd::ActiveRecord
