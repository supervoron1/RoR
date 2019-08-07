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
          # По ТЗ в тип передается :presence/:format/:type
          # Нужно собрать название метода:
          # method_name = "validate_#{validation[:type]}"
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

    def validate_presence(attr_name)
      raise "Значение атрибута #{attr_name} не может быть nil" if attr_name.nil?
      # Нужно наверно имя атрибута передавать и выводить
      # "Значение атрибута #{attr_name}..."

      raise "Значение атрибута #{attr_name} не может быть пустой строкой" if attr_name.strip.empty?
    end

    def validate_format(attr_name, format)
      raise "Значение атрибута #{attr_name} не соответствует формату #{format}" if attr_name !~ format
    end

    def validate_type(attr_name, type)
      raise "Значение атрибута #{attr_name} не соответствует классу #{type}" unless attr_name.is_a?(type)
    end
  end
end
