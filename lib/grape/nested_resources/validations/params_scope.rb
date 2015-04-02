module Grape
  module Validations
    class ParamsScope

      def requires_or_optional(*attrs, &block)
        optional(*attrs, &block)
      end

    end
  end
end