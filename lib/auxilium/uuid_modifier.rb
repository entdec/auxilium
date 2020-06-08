module Auxilium
  class UuidModifier
    class << self

      def minimize(uuid)
        uuid.delete('-')
      end

      def append(uuid, value)
        "#{minimize(uuid)}/#{value}"
      end

      def reconstitute(id)
        "#{id[0..7]}-#{id[8..11]}-#{id[12..15]}-#{id[16..19]}-#{id[20..31]}"
      end
    end
  end
end
