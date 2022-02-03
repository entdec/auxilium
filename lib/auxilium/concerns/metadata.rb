# frozen_string_literal: true

module Auxilium
  module Concerns
    module Metadata
      extend ActiveSupport::Concern

      def metadata_yaml=(yaml)
        write_attribute :metadata, YAML.safe_load(yaml.gsub("\t", '  '))
      end

      def metadata_yaml
        return '' if metadata.nil? || metadata.empty?

        YAML.dump(attributes['metadata'])
      end
    end
  end
end
