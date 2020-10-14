module ForemanWebsocketExample
  # Example: Plugin's HostsController inherits from Foreman's HostsController
  class HostsController < ::HostsController
    # change layout if needed
    # layout 'foreman_websocket_example/layouts/new_layout'

    def new_action
      # automatically renders view/foreman_websocket_example/hosts/new_action
    end
  end
end
