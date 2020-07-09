# frozen_string_literal: true

class Integer
  # Divides this Integer into chunks of the given size.
  # When the random option is given the chunk size is randomized per chunk
  # using the chunk_size as the maximum value.
  def chunks_of(chunk_size, random: false)
    number = self.dup
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
