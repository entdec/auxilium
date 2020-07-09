# frozen_string_literal: true

require 'test_helper'

module Auxilium
  class EasyCryptTest < ActiveSupport::TestCase
    test 'EasyCrypt' do
      crypt = EasyCrypt.new('test')

      assert_not_equal 'test', crypt.encrypt('test')
      assert_equal 'test', crypt.decrypt(crypt.encrypt('test'))
    end

    test 'double no double' do
      crypt = EasyCrypt.new('test')
      crypted = crypt.encrypt('test')

      assert_equal crypted, crypt.encrypt(crypted)
      assert_not_equal 'someothertext', crypt.encrypt('someothertext')

      assert_equal 'test', crypt.decrypt(crypt.encrypt(crypt.encrypt('test')))
    end
  end
end
