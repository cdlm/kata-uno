task default: :quality

desc 'Run unit & behavior tests'
task features: [:test, :cucumber]

desc 'Check code style conventions'
task lint: :rubocop

desc 'Run all quality checks'
task quality: [:test, :features, :lint]

require 'rake/testtask'
Rake::TestTask.new do |t|
  # t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = 'features --format pretty'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new do |task|
  task.formatters = ['clang']
end

require 'rubygems/tasks'
Gem::Tasks.new(push: false) do |tasks|
  tasks.console.command = 'pry'
end
task build: :features
