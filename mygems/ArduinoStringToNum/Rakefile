require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/extensiontask"

Rake::ExtensionTask.new "ArduinoBinTo" do |ext|
  ext.lib_dir = "lib/ArduinoStringToNum"
end
RSpec::Core::RakeTask.new(:spec) do
  Rake::Task[:compile].invoke
end

task :default => :spec
