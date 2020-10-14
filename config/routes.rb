Rails.application.routes.draw do
  get 'new_action', to: 'foreman_websocket_example/hosts#new_action'
end
