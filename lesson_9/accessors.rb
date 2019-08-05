# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        instance_variable_set("@#{name}_history", []) unless instance_variable_get("@#{name}_history")
        instance_variable_get("@#{name}_history") << value
      end

      define_method("#{name}_history") { instance_variable_get("@#{name}_history") }
    end
  end

  def strong_attr_accessor(name, attr_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
      raise "Type Error!!!" unless value.is_a?(attr_class)

      instance_variable_set(var_name, value)
    end
  end
end
