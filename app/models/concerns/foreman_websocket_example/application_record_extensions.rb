module ForemanWebsocketExample
  module ApplicationRecordExtensions
    extend ActiveSupport::Concern

    included do
      after_create do
        ActionCable.server.broadcast('global_changes', type: self.class.name, action: :create, record: attributes)
      end

      after_update do
        ActionCable.server.broadcast('global_changes', type: self.class.name, action: :update, record: attributes)
      end

      after_destroy do
        ActionCable.server.broadcast('global_changes', type: self.class.name, action: :destroy, record: attributes)
      end
    end
  end
end
