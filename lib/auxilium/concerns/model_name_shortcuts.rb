# frozen_string_literal: true

module Auxilium
  module Concerns
    module ModelNameShortcuts
      extend ActiveSupport::Concern

      included do
        delegate :singular_model_name, :plural_model_name, to: :class
      end

      class_methods do
        def singular_model_name
          model_name.human(count: 1)
        end

        def plural_model_name
          model_name.human(count: 2)
        end
      end
    end
  end
end
