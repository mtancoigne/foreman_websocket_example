require 'rake/testtask'

# Tasks
namespace :foreman_websocket_example do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanWebsocketExample'
  Rake::TestTask.new(:foreman_websocket_example) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_websocket_example do
  task rubocop: :environment do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_websocket_example) do |task|
        task.patterns = ["#{ForemanWebsocketExample::Engine.root}/app/**/*.rb",
                         "#{ForemanWebsocketExample::Engine.root}/lib/**/*.rb",
                         "#{ForemanWebsocketExample::Engine.root}/test/**/*.rb"]
      end
    rescue StandardError
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_websocket_example'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_websocket_example']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_websocket_example', 'foreman_websocket_example:rubocop']
end
