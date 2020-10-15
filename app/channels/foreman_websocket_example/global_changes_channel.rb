module ForemanWebsocketExample
  class GlobalChangesChannel < ApplicationCable::Channel
    def subscribed
      Rails.logger.debug 'Someone subscribed to the global changes Channel'

      stream_from 'global_changes'
    end
  end
end
