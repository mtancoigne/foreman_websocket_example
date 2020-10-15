# ForemanWebsocketExample

**Example plugin** for Foreman that uses websocket to publish actions (create/update/destroy) on _all_ models.

## Installation

Clone/download the plugin and update Foreman's Gemfile with:

```rb
gem 'foreman_websocket_example', path: '../path_to_plugin'
```

The plugin uses Redis, even in development (see `config/cable.yml`), so you will need a Redis server for this:

```shell
# For Debian/Ubuntu
sudo apt install redis
```

Edit the Foreman URL in `example_client/index.html`

## Usage

- Once installed, start Foreman.
- Open the client in your browser (`example_client/index.html`), open the developper tools and check the JS console
- Create/update/destroy things (a safe example is to create an organization or location) in Foreman
- Look at the console.

## Known issues

Don't install the plugin if you have not ran the Foreman's migration, or the migrations will fail.

## How it works

- Plugin loads ActionCable and configures it (check `lib/foreman_websocket_example/engine.rb`, `config/cable.yml`)
- Plugins adds a concern to `ApplicationRecord` class, with hooks (see `app/models/concerns/application_record_extension.rb`)
- On `after_create`, `after_update` and `after_destroy`, data is broadcasted to `GlobalChanges` channel (see `app/channels/foreman_websocket_example/global_changes_channel`) 

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2020 Opus Codium

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

