# frozen_string_literal: true

module Auxilium
  module Concerns
    module Authenticated
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_user_from_token!
        before_action :authenticate_user!
        before_action :set_user, :log_request_details
      end
    end
  end
end
