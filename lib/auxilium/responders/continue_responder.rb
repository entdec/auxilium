# frozen_string_literal: true

# This responder modifies your current responder to redirect
# to the collection page on POST/PUT/DELETE if you use save, not for 'continue'.
module Auxilium
  module ContinueResponder
    protected

    def navigation_location
      return options[:location] if options[:location] && controller.is_a?(Devise::SessionsController)
      return options[:location] if controller.params[:commit] == 'continue' && options[:location]
      return options[:collection_location].call if %w[save commit].include?(controller.params[:commit]) && options[:collection_location]
      return resource_location if controller.params[:commit] == 'continue'

      klass = resources.last.class

      if klass.respond_to?(:model_name)
        resources[0...-1] << klass.model_name.route_key.to_sym
      else
        resources
      end
    end

    def navigation_behavior(error)
      if get?
        raise error
      elsif has_errors? && default_action
        render error_rendering_options
      else
        redirect_to navigation_location, status: :see_other
      end
    end
  end
end
