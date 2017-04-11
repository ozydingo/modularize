module Modularize
  class Modularizer
    def initialize(namespace, name, type = Module, inherit: nil)
      @namespace = namespace
      @name = name.to_s
      @type = type
      @inherit = @inherit.nil? ? type == Class : !!inherit

      validate
    end

    def modularize
      modularized? ? @namespace.const_get(@name) : @namespace.const_set(@name, create_template)
    end

    def modularized?
      @namespace.const_defined?(@name) && @namespace.const_get(@name).parent == @namespace.parent
    end

    private

    def create_template
      @type == Class ? new_class : Module.new
    end

    def new_module
      Module.new
    end

    def new_class
      return Class.new(*superklass)
    end

    def superklass
      superklass_exists? ? @namespace.superclass.const_get(@name) : nil
    end

    def superklass_exists?
      @namespace.is_a?(Class) && !@namespace.superclass.nil? && @namespace.superclass.const_defined?(@name)
    end

    def validate
      raise "namespace must be a Module or Class " if !@namespace.is_a?(Module)
      raise "type must be Module or Class" if ![Class, Module].include?(@type)
      raise "inherit: true with Module namespace makes no sense!" if @inherit && !@namespace.is_a?(Class)
      raise "inherit: true with Module type makes no sense!" if @inherit && @type == Module
    end
  end
end
