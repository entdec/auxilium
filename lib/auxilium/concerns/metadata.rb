# frozen_string_literal: true

module Auxilium
  module Concerns
    module Metadata
      extend ActiveSupport::Concern

      included do
        validates :metadata_yaml, yaml: true
      end

      def metadata_yaml=(yaml)
        write_attribute :metadata, YAML.safe_load(yaml.gsub("\t", '  '))
      rescue StandardError
        write_attribute :metadata, yaml
      end

      def metadata_yaml
        return '' if attributes['metadata'].blank?

        if attributes['metadata'].is_a? String
          begin
            YAML.load(attributes['metadata'])
          rescue StandardError
            attributes['metadata']
          end
        else
          YAML.dump(attributes['metadata'])
        end
      end

      def metadata
        attributes['metadata'].present? && HashWithIndifferentAccess.new(attributes['metadata'])
      end
    end
  end
end
