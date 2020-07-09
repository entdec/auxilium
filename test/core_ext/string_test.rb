require 'test_helper'

class StringTest < ActiveSupport::TestCase
  test 'downcase only the first character' do
    assert_equal 'oh my word', 'Oh my word'.downcase_first
  end
end

