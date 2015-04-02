require 'active_support/core_ext/object/blank'

module Grape
  module Validations
    class DependsOf < Grape::Validations::Base

      def validate!(params)
        attributes = Grape::Validations::AttributesIterator.new(self, @scope, params)
        attributes.each do |resource_params, attr_name|
          validate_param!(attr_name, resource_params) if resource_params.respond_to?(:key?)
        end
      end

      def validate_param!(attr_name, params)
        return if params.key?(attr_name) && params[attr_name].present?

        unless params.key?(@option) && params[@option].present?
          fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message_key: :presence
        end
      end

    end
  end
end