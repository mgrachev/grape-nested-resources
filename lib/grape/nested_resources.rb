require 'grape'
require 'active_support/concern'
require 'active_support/core_ext/string/inflections'

module Grape
  module NestedResources
    extend ActiveSupport::Concern

    module ClassMethods
      def nested_resource(**kwargs)
        kwargs.each do |key, value|

          root = key.to_s.pluralize
          paths = []

          prepared_value = Array(value).flatten.map { |a| a.to_s.pluralize }
          paths << _build_rest_uri(root, *prepared_value)
          paths << prepared_value.pop

          nested_params = [root, *[prepared_value]].flatten.map do |param|
            param.singularize.foreign_key
          end

          paths.each do |path|
            resource path do
              yield nested_params
            end
          end
        end
      end

      def add_required_params(params)
        Grape::Validations::ParamsScope.new(api: self, type: Hash).add_required_params(params)
      end

      private

      def _build_rest_uri(*elements)
        target = elements.pop

        rest_uri = elements.flat_map do |element|
          [element, ":#{element.singularize.foreign_key}"]
        end
        rest_uri.push(target).join('/')
      end
    end

  end
end

require_relative 'nested_resources/validations/depends_on'
require_relative 'nested_resources/validations/params_scope'

if defined? Grape
  Grape::API.send(:include, Grape::NestedResources)
end
