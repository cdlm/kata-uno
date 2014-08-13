task default: :quality

desc 'Run unit & behavior tests'
task features: [:test, :cucumber]

desc 'Check code style conventions'
task lint: :rubocop

desc 'Run all quality checks'
task quality: [:test, :features, :lint]

require 'rake/clean'
CLEAN.include 'coverage'

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = 'features --format pretty --strict'
end
CLEAN.include 'tmp/'

require 'rubocop/rake_task'
RuboCop::RakeTask.new do |task|
  task.formatters = ['simple']
end

require 'rubygems/tasks'
Gem::Tasks.new(push: false) do |tasks|
  tasks.console.command = 'pry'
end
task build: :features
CLEAN.include 'pkg/'

# Processing sample files
#
SAMPLES_DIR = 'samples'
SAMPLES = FileList[File.join SAMPLES_DIR, '**/*.in.uno']
def out_file(file)  file.sub(/\.(in\.)?uno$/, '.out.uno')  end
def diff_file(file)  file.sub(/\.(in\.)?uno$/, '.uno.diff')  end

desc 'Generate reference output & diffs from samples'
multitask :samples

SAMPLES.each do |uno|
  out, diff = out_file(uno), diff_file(uno)

  file out => file(uno) do
    sh "bundle exec ./bin/uno '#{uno}' > '#{out}'"
  end

  file diff => file(out) do
    sh "diff -buN '#{uno}' '#{out}' > '#{diff}'" do |success, result|
      fail unless success || result.exitstatus == 1
    end
  end

  task samples: [file(out), file(diff)]
  CLEAN.include out, diff
end
