module Grape
  module Validations
    class ParamsScope

      def requires_or_optional(*attrs, &block)
        optional(*attrs, &block)
      end

      def add_required_params(params)
        params.flatten.map do |param|
          requires param.to_sym, type: Integer, desc: param.titleize
        end
      end

    end
  end
end