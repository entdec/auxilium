# frozen_string_literal: true

module Auxilium
  class IntegerChunker
    def initialize(number)
      @number = number
    end

    def chunks_of(chunk_size, random: false)
      number = @number
      chunks = []

      while number > 0
        this_chunk_size = random ? rand(chunk_size - 1) + 1 : chunk_size
        number -= this_chunk_size

        if number < 0
          this_chunk_size += number
          number = 0
        end

        chunks << this_chunk_size
      end

      chunks
    end
  end
end
