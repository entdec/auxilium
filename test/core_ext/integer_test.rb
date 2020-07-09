# frozen_string_literal: true

require 'test_helper'

class IntegerTest < ActiveSupport::TestCase
  setup do
    srand(67809)
  end

  test 'split number into equal chunks' do
    assert_equal [12, 12, 12, 12], 48.chunks_of(12)
  end

  test 'split number into chunks gives the last chunk the leftovers' do
    assert_equal [12, 12, 12, 5], 41.chunks_of(12)
  end

  test 'split number into randomized chunks' do
    assert_equal [3, 2, 8, 8, 5, 3, 7, 5], 41.chunks_of(12, random: true)
  end
end

