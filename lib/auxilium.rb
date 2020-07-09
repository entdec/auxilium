# frozen_string_literal: true

require 'auxilium/version'
require 'active_support'

require 'core_ext/string'
require 'auxilium/easy_crypt'
require 'auxilium/integer_chunker'
require 'auxilium/concerns'
require 'auxilium/concerns/metadata_scoped'
require 'auxilium/concerns/model_name_shortcuts'
require 'auxilium/grape'
require 'auxilium/grape/parameter_filter'
require 'auxilium/uuid_modifier'

module Auxilium
  class Error < StandardError; end
  # Your code goes here...
end
