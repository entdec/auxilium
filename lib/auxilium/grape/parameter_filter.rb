module Auxilium
  module Grape
    class ParameterFilter
      class << self
        FILTER_REGEX = /password|token/i

        def filter(hash, regex = FILTER_REGEX)
          hash = hash.dup
          hash.each do |k, v|
            hash[k] = '[FILTERED]' if k.to_s =~ FILTER_REGEX
            hash[k] = filter(v, regex) if v.is_a?(Hash)
            hash[k] = v.map { |v| v.is_a?(Hash) ? filter(v, regex) : v } if v.is_a?(Array)
          end

          hash
        end
      end
    end
  end
end
