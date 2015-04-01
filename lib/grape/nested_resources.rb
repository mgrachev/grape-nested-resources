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

          Grape::Validations::ParamsScope.new(api: self, type: Hash) do
            [root, *[prepared_value]].flatten.each do |param|
              attr = "#{param.singularize}_id"
              requires attr.to_sym, type: Integer, desc: attr.titleize
            end
          end

          paths.each { |path| yield path }
        end
      end

      private

      def _build_rest_uri(*elements)
        target = elements.pop

        rest_uri = elements.flat_map do |element|
          [element, ":#{element.singularize}_id"]
        end
        rest_uri.push(target).join('/')
      end
    end

  end
end

if defined? Grape
  Grape::API.send(:include, Grape::NestedResources)
end
