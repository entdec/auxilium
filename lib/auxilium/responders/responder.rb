module Auxilium
  class Responder < ActionController::Responder
    include Responders::HttpCacheResponder

    include SignumResponder
    include ContinueResponder

    self.error_status = :unprocessable_entity
    self.redirect_status = :see_other
  end
end
