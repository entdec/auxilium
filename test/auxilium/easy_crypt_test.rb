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
    
    test 'using sha256 cannot decrypt with sha1 but will decrypt with sha256' do
      crypt = EasyCrypt.new('test', OpenSSL::Digest::SHA256)
      crypted = crypt.encrypt('supersecret')

      decrypt_sha256 = EasyCrypt.new('test', OpenSSL::Digest::SHA256)
      assert_equal 'supersecret', decrypt_sha256.decrypt(crypted)
      
      decrypt_sha1 = EasyCrypt.new('test', OpenSSL::Digest::SHA1)
      assert_raises(ActiveSupport::MessageEncryptor::InvalidMessage) { decrypt_sha1.decrypt(crypted)}
    end

    test 'using sha1 cannot decrypt with sha256 but will decrypt with sha1' do
      crypt = EasyCrypt.new('test', OpenSSL::Digest::SHA1)
      crypted = crypt.encrypt('supersecret')

      decrypt_sha1 = EasyCrypt.new('test', OpenSSL::Digest::SHA1)
      assert_equal 'supersecret', decrypt_sha1.decrypt(crypted)
      
      decrypt_sha256 = EasyCrypt.new('test', OpenSSL::Digest::SHA256)
      assert_raises(ActiveSupport::MessageEncryptor::InvalidMessage) { decrypt_sha256.decrypt(crypted)}
    end
  end
end
