# frozen_string_literal: true

require 'test_helper'
require 'pry'

module Auxilium
  class StateValidatorTest < ActiveSupport::TestCase
    test 'validates that state is one of the values in only' do
      klass = test_klass do
        attr_accessor :state
        validates :state, state: { only: %w[active inactive] }
      end

      object = klass.new(state: 'active')
      assert object.valid?

      object = klass.new(state: 'inactive')
      assert object.valid?

      object = klass.new
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:state]

      object = klass.new(state: 'noop')
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:state]
    end

    test 'validates that state is not one of the values in except' do
      klass = test_klass do
        attr_accessor :state
        validates :state, state: { except: %w[concept inactive] }
      end

      object = klass.new(state: 'active')
      assert object.valid?

      object = klass.new(state: 'concept')
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:state]

      object = klass.new(state: 'inactive')
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:state]
    end

    test 'validates nil state with allow_nil = true' do
      klass = test_klass do
        attr_accessor :state
        validates :state, state: { only: %w[active inactive], allow_nil: true }
      end

      object = klass.new
      assert object.valid?

      object = klass.new(state: 'invalid')
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:state]
    end

    test 'validates that attribute object state is one of the values in only' do
      klass = test_klass do
        attr_accessor :account
        validates :account, state: { only: %w[active inactive] }
      end

      object = klass.new(account: OpenStruct.new(state: 'active'))
      assert object.valid?

      object = klass.new(account: OpenStruct.new(state: nil))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]

      object = klass.new(account: OpenStruct.new(state: 'noop'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]
    end

    test 'validates that attribute object state with an alternative state attribute name is one of the values in only' do
      klass = test_klass do
        attr_accessor :account
        validates :account, state: { only: %w[active inactive], state: :my_state }
      end

      object = klass.new(account: OpenStruct.new(my_state: 'active'))
      assert object.valid?

      object = klass.new(account: OpenStruct.new(my_state: nil))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]

      object = klass.new(account: OpenStruct.new(my_state: 'noop'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]
    end

    test 'validates that attribute object state is not one of the values in except' do
      klass = test_klass do
        attr_accessor :account
        validates :account, state: { except: %w[concept inactive] }
      end

      object = klass.new(account: OpenStruct.new(state: 'active'))
      assert object.valid?

      object = klass.new(account: OpenStruct.new(state: 'concept'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]

      object = klass.new(account: OpenStruct.new(state: 'inactive'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]
    end

    test 'validates that attribute object state with an alternative state attribute name is not one of the values in except' do
      klass = test_klass do
        attr_accessor :account
        validates :account, state: { except: %w[concept inactive], state: :my_state }
      end

      object = klass.new(account: OpenStruct.new(my_state: 'active'))
      assert object.valid?

      object = klass.new(account: OpenStruct.new(my_state: 'concept'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]

      object = klass.new(account: OpenStruct.new(my_state: 'inactive'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]
    end

    test 'validates nil state on attribute object with allow_nil = true' do
      klass = test_klass do
        attr_accessor :account
        validates :account, state: { only: %w[active inactive], allow_nil: true }
      end

      object = klass.new
      assert object.valid?

      object = klass.new(account: OpenStruct.new(state: nil))
      assert object.valid?

      object = klass.new(account: OpenStruct.new(state: 'invalid'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]
    end

    test 'validates nil state on attribute object with an alternative attribute name and allow_nil = true' do
      klass = test_klass do
        attr_accessor :account
        validates :account, state: { only: %w[active inactive], state: :my_state, allow_nil: true }
      end

      object = klass.new
      assert object.valid?

      object = klass.new(account: OpenStruct.new(my_state: nil))
      assert object.valid?

      object = klass.new(account: OpenStruct.new(my_state: 'invalid'))
      refute object.valid?
      assert_equal ['is not an allowed state'], object.errors[:account]
    end

    private

    def test_klass(&block)
      Class.new do
        include ActiveModel::Model
        include ActiveModel::Validations

        def self.name
          'Test'
        end

        class_exec(&block)
      end
    end
  end
end
