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
      rescue StandardError => e
        write_attribute :metadata, yaml
      end

      def metadata_yaml
        return '' if attributes['metadata'].blank?

        if attributes['metadata'].is_a? Hash
          YAML.dump(attributes['metadata'])
        else
          begin
            YAML.load(attributes['metadata'])
          rescue StandardError => e
            attributes['metadata']
          end
        end
      end
    end
  end
end