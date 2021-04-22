# frozen_string_literal: true

module Auxilium
  module SignumResponder
    class << self
      attr_accessor :signum_keys, :namespace_lookup, :helper
    end

    self.signum_keys = %i[success error]
    self.namespace_lookup = false
    self.helper = Object.new.extend(
      ActionView::Helpers::TranslationHelper,
      ActionView::Helpers::TagHelper
    )

    def initialize(controller, resources, options = {})
      super
      @signum = options.delete(:signum)
      @success = options.delete(:success)
      @error = options.delete(:error)
    end

    def to_html
      send_signum! if send_signum?
      super
    end

    def to_js
      send_signum! if send_signum?
      defined?(super) ? super : to_format
    end

    protected

    def send_signum!
      if has_errors?
        status = SignumResponder.signum_keys.last
        send_signum(status, @error)
      else
        status = SignumResponder.signum_keys.first
        send_signum(status, @success)
      end

      return if sent_signum?

      options = mount_i18n_options(status)
      message = SignumResponder.helper.t options[:default].shift, **options
      send_signum(status, message)
    end

    def send_signum(key, value)
      return if value.blank?

      @sent_signum = true
      Signum.signal(controller.current_user, text: value, kind: key)
    end

    def send_signum? #:nodoc:
      !get? && @signum != false
    end

    def sent_signum?
      @sent_signum == true
    end

    def mount_i18n_options(status) #:nodoc:
      options = {
        default: signum_defaults_by_namespace(status),
        resource_name: resource_name,
        downcase_resource_name: resource_name.downcase
      }

      controller_options = controller_interpolation_options
      options.merge!(controller_options) if controller_options

      options
    end

    def controller_interpolation_options
      controller.send(:signum_interpolation_options) if controller.respond_to?(:signum_interpolation_options, true)
    end

    def resource_name
      if resource.class.respond_to?(:model_name)
        resource.class.model_name.human
      else
        resource.class.name.underscore.humanize
      end
    end

    def signum_defaults_by_namespace(status) #:nodoc:
      defaults = []
      slices   = controller.controller_path.split('/')
      lookup   = SignumResponder.namespace_lookup

      begin
        controller_scope = :"signum.#{slices.fill(controller.controller_name, -1).join('.')}.#{controller.action_name}.#{status}"

        actions_scope = lookup ? slices.fill('actions', -1).join('.') : :actions
        actions_scope = :"signum.#{actions_scope}.#{controller.action_name}.#{status}"

        defaults << :"#{controller_scope}_html"
        defaults << controller_scope

        defaults << :"#{actions_scope}_html"
        defaults << actions_scope

        slices.shift
      end while slices.size > 0 && lookup

      defaults << ''
    end
  end
end
