SimpleCov.use_merging true
SimpleCov.start do
  add_filter 'test/'
  add_filter 'features/'

  formatter SimpleCov::Formatter::HTMLFormatter
end
