# frozen_string_literal: true

require 'auxilium/version'
require 'active_support'

require 'auxilium/easy_crypt'
require 'auxilium/concerns'
require 'auxilium/concerns/metadata_scoped'
require 'auxilium/grape'
require 'auxilium/grape/parameter_filter'
require "auxilium/uuid_modifier"

module Auxilium
  class Error < StandardError; end
  # Your code goes here...
end
