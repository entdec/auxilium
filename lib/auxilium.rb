# frozen_string_literal: true

require 'auxilium/version'
require 'active_support'
require 'active_model'
require 'pundit'
require 'responders'
require 'rolify'

require 'i18n'
I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'auxilium', 'locale', '*.{rb,yml}')]

require 'core_ext/string'
require 'auxilium/easy_crypt'
require 'auxilium/integer_chunker'
require 'auxilium/concerns'
require 'auxilium/concerns/admin_authenticated'
require 'auxilium/concerns/authenticated'
require 'auxilium/concerns/metadata_scoped'
require 'auxilium/concerns/model_name_shortcuts'
require 'auxilium/responders/continue_responder'
require 'auxilium/responders/signum_responder'
require 'auxilium/responders/responder'
require 'auxilium/validators/state_validator'
require 'auxilium/validators/unchanged_validator'
require 'auxilium/grape'
require 'auxilium/grape/parameter_filter'
require 'auxilium/uuid_modifier'

module Auxilium
  class Error < StandardError; end
  # Your code goes here...
end

