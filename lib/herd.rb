require "herd/version"

module Herd
  class Base # :nodoc:
    class_attribute :model_class

    # DSL method for manually setting the model
    def self.model(model)
      self.model_class = model
    end

    # Add all class methods to the model class so that these methods are
    # available to ActiveRecord::Relation etc
    def self.inherited(klass)
      klass.class_eval do
        def self.singleton_method_added(method_name)
          return if model_class.nil? || method_name == :model_class

          method = self.method(method_name).to_proc
          model_class.define_singleton_method(method_name, method)
        end
      end
    end

    # Delegate all methods to the model class if you want to do something like:
    # Collection.find_by_name('blah')
    def self.method_missing(method, *args, &block)
      if model_class.respond_to?(method)
        model_class.send(method, *args, &block)
      else
        super
      end
    end
  end
end
