module ForemanWebsocketExample
  class Engine < ::Rails::Engine
    engine_name 'foreman_websocket_example'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer 'foreman_websocket_example.load_app_instance_data' do |app|
      ForemanWebsocketExample::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_websocket_example.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_websocket_example do
        requires_foreman '>= 1.16'

        # Add permissions
        security_block :foreman_websocket_example do
          permission :view_foreman_websocket_example, :'foreman_websocket_example/hosts' => [:new_action]
        end

        # Add a new role called 'ForemanWebsocketExample' if it doesn't exist
        role 'ForemanWebsocketExample', [:view_foreman_websocket_example]

        # add menu entry
        menu :top_menu, :template,
             url_hash: { controller: :'foreman_websocket_example/hosts', action: :new_action },
             caption: 'ForemanWebsocketExample',
             parent: :hosts_menu,
             after: :hosts

        # add dashboard widget
        widget 'foreman_websocket_example_widget', name: N_('Foreman plugin template widget'), sizex: 4, sizey: 1
      end
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanWebsocketExample::HostExtensions)
        HostsHelper.send(:include, ForemanWebsocketExample::HostsHelperExtensions)
      rescue => e
        Rails.logger.warn "ForemanWebsocketExample: skipping engine hook (#{e})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanWebsocketExample::Engine.load_seed
      end
    end

    initializer 'foreman_websocket_example.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_websocket_example'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
