# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validators

    def validate(attr_name, type, *attributes)
      @validators ||= {}
      @validators[attr_name] ||= []
      @validators[attr_name] << { type: type, attributes: attributes }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validators.each do |attr_name, validations|
        attr_value = instance_variable_get("@#{attr_name}")
        validations.each do |validation|
          send(validation[:type], attr_value, *validation[:attributes])
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(value)
      raise "Значение атрибута #{value} не может быть nil" if value.nil?
      raise "Значение атрибута #{value} не может быть пустой строкой" if value.strip.empty?
    end

    def validate_format(value, format)
      raise "Значение атрибута #{value} не соответствует формату #{format}" if value !~ format
    end

    def validate_type(value, type)
      raise "Значение атрибута #{value} не соответствует классу #{type}" unless value.is_a?(type)
    end
  end
end
