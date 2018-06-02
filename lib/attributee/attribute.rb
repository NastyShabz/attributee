# frozen_string_literal: true

class Attributee::Attribute
  attr_reader :name, :old_value
  attr_accessor :value

  def initialize(name, value)
    raise ArgumentError, "'name' should be a symbol" unless name.instance_of?(Symbol)

    @name = name
    @value = value
    @old_value = value
  end

  def changed?
    value != old_value
  end

  def change
    return unless changed?

    {
      old: old_value,
      new: value
    }
  end
end
