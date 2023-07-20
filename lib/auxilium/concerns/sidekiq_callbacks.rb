require "active_support/callbacks"

# Following approach used by ActiveJob
# https://github.com/rails/rails/blob/93c9534c9871d4adad4bc33b5edc355672b59c61/activejob/lib/active_job/callbacks.rb
module Auxilium
  module Concerns
    module SidekiqCallbacks
      extend ActiveSupport::Concern

      def self.prepended(base)
        base.include(ActiveSupport::Callbacks)

        # Check to see if we already have any callbacks for :perform
        # Prevents overwriting callbacks if we already included this module (and defined callbacks)
        base.define_callbacks :perform unless base.respond_to?(:_perform_callbacks) && base._perform_callbacks.present?
        base.define_callbacks :enqueue unless base.respond_to?(:_enqueue_callbacks) && base._enqueue_callbacks.present?

        class << base
          prepend ClassMethods
        end
      end

      def perform(*args)
        if respond_to?(:run_callbacks)
          run_callbacks :perform do
            super(*args)
          end
        else
          super(*args)
        end
      end

      def enqueue(*args)
        if respond_to?(:run_callbacks)
          run_callbacks :enqueue do
            super(*args)
          end
        else
          super(*args)
        end
      end

      module ClassMethods
        def around_perform(*filters, &blk)
          set_callback(:perform, :around, *filters, &blk)
        end

        def before_enqueue(*filters, &blk)
          set_callback(:enqueue, :before, *filters, &blk)
        end

        def around_enqueue(*filters, &blk)
          set_callback(:enqueue, :around, *filters, &blk)
        end

        def before_perform(*filters, &blk)
          set_callback(:perform, :before, *filters, &blk)
        end
      end
    end

  end
end
