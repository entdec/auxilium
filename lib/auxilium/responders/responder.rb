module Auxilium
  class Responder < ActionController::Responder
    include Responders::HttpCacheResponder

    include SignumResponder
    include ContinueResponder
  end
end
