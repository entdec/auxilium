# frozen_string_literal: true

module Auxilium
  module Concerns
    module AdminAuthenticated
      extend ActiveSupport::Concern

      def admin_authenticated
        authenticate_user!

        redirect_to main_app.root_path unless current_user.has_role?(:admin)
      end

      included do
        before_action :admin_authenticated
      end
    end
  end
end
