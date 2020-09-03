module Auxilium
  class EasyCrypt
    def initialize(key_base)
      @key_base = key_base
    end

    def encrypt(text)
      text = text.to_s unless text.is_a?(String)

      # Return the crypted text is it was already crypted by this routine
      return text if crypted?(text)
      return text if text.blank?

      data = encrypted(text)
      raise StandardError, 'WTF' unless decrypt(data)
      data
    end

    def decrypt(data)
      return data unless crypted?(data)

      salt, data = data.gsub(/^EasyCrypt@/, '').split("$$", 2)

      crypt(salt).decrypt_and_verify(data)
    end

    private

    def encrypted(text)
      salt = generate_salt
      encrypted_data = crypt(salt).encrypt_and_sign(text)

      "EasyCrypt@#{salt}$$#{encrypted_data}"
    end

    def crypt(salt)
      key = ActiveSupport::KeyGenerator.new(@key_base).generate_key(salt, key_length)
      ActiveSupport::MessageEncryptor.new(key, cipher: 'aes-256-gcm')
    end

    def key_length
      @key_length ||= ActiveSupport::MessageEncryptor.key_len
    end

    def generate_salt
      SecureRandom.hex(key_length)
    end

    def crypted?(text)
      text =~ /^EasyCrypt@[0-9a-f]+\$\$[^-]+--[^-]+--[^-]+/
    end
  end
end
