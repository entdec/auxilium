# frozen_string_literal: true

module Auxilium
  module Concerns
    module MetadataScoped
      extend ActiveSupport::Concern

      included do
        scope :metadata_blank, lambda { |name|
          where('metadata->>:name IS NULL', name: name)
        }

        scope :metadata_eql, lambda { |name, value|
          where('metadata->>:name = :value', name: name, value: value)
        }

        scope :metadata_blank_or_eql, lambda { |name, value|
          where('metadata->>:name IS NULL OR metadata->>:name = :value', name: name, value: value)
        }

        scope :metadata_eql_or_blank_exclusive, lambda { |name, value|
          result = where('metadata->>:name = :value', name: name, value: value)
          result = where('metadata->>:name IS NULL', name: name) if result.none?
          result
        }

        scope :metadata_in, lambda { |name, value|
          where('metadata->>:name IN (:value)', name: name, value: value)
        }

        scope :metadata_blank_or_in, lambda { |name, value|
          where('metadata->>:name IS NULL OR metadata->>:name IN (:value)', name: name, value: value)
        }

        scope :metadata_in_or_blank_exclusive, lambda { |name, value|
          result = where('metadata->>:name IN (:value)', name: name, value: value)
          result = where('metadata->>:name IS NULL', name: name) if result.none?
          result
        }

        scope :metadata_contains, lambda { |name, value|
          where('(metadata->>:name)::jsonb ? :value', name: name, value: value)
        }

        scope :contains, lambda { |name, value|
          ActiveSupport::Deprecation.warn('Use metdata_contains instead')
          metadata_contains(name, value)
        }

        scope :metadata_contains_or_blank, lambda { |name, value|
          where('(metadata->>:name)::jsonb ? :value OR metadata->>:name IS NULL', name: name, value: value)
        }

        scope :contains_or_blank, lambda { |name, value|
          ActiveSupport::Deprecation.warn('Use metdata_contains_or_blank instead')
          metadata_contains_or_blank(name, value)
        }

        scope :metadata_contains_or_blank_exclusive, lambda { |name, value|
          result = where('(metadata->>:name)::jsonb ? :value', name: name, value: value)
          result = where('metadata->>:name IS NULL', name: name) if result.none?
          result
        }

        scope :contains_or_blank_exclusive, lambda { |name, value|
          ActiveSupport::Deprecation.warn('Use metdata_contains_or_blank_exclusive instead')
          metadata_contains_or_blank_exclusive(name, value)
        }
      end
    end
  end
end
