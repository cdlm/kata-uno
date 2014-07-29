task default: :test
task all: [:test, :features, :rubocop]

require 'rake/testtask'
Rake::TestTask.new do |t|
  # t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty'
end
task features: :test

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.formatters = ['clang']
end

require 'rubygems/tasks'
Gem::Tasks.new(push: false) do |tasks|
  tasks.console.command = 'pry'
end
