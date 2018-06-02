require 'attributee/version'
require 'attributee/attribute'

module Attributee
  def self.included(klass)
    klass.extend AttributeeClassMethods
  end

  def initialize(attributes)
    @attributes = {}

    attributes.each { |n, v| @attributes[n] = Attribute.new(n, v) }
  end

  def attribute(name)
    @attributes[name]
  end

  def attributes
    result = {}
    @attributes.each { |n, a| result[n] = a.value }
    result
  end

  module AttributeeClassMethods
    def def_attribute(name)
      define_method name do
        @attributes[name].value
      end

      define_method "#{name}=" do |value|
        @attributes[name].value = value
      end
    end
  end
end
