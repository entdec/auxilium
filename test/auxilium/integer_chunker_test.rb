# frozen_string_literal: true

require 'test_helper'

module Auxilium
  class IntegerChunkerTest < ActiveSupport::TestCase
    setup do
      srand(67809)
    end

    test 'split number into equal chunks' do
      chunker = IntegerChunker.new(48)
      assert_equal [12, 12, 12, 12], chunker.chunks_of(12)
      assert_equal [12, 12, 12, 12], chunker.chunks_of(12)
    end

    test 'split number into chunks gives the last chunk the leftovers' do
      chunker = IntegerChunker.new(41)
      assert_equal [12, 12, 12, 5], chunker.chunks_of(12)
      assert_equal [12, 12, 12, 5], chunker.chunks_of(12)
    end

    test 'split number into randomized chunks' do
      chunker = IntegerChunker.new(41)
      assert_equal [3, 2, 8, 8, 5, 3, 7, 5], chunker.chunks_of(12, random: true)
      assert_equal [6, 10, 7, 6, 9, 3], chunker.chunks_of(12, random: true)
    end
  end
end
