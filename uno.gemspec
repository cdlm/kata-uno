Gem::Specification.new do |s|
  s.name        = 'uno'
  s.version     = '0.0.0'
  s.date        = '2014-07-28'

  s.authors     = ['Damien Pollet']
  s.email       = 'damien.pollet@telecom-lille.fr'
  # s.homepage    = ''
  s.license     = 'MIT'

  s.summary     = 'Uno rules checker'
  s.description = <<-DESCRIPTION
A rule checker for the cards game Uno

This is a reference implementation for a Java programming assignment.
DESCRIPTION

  s.files       = Dir['lib/**/*.rb']
  s.executables << 'uno'

  s.add_runtime_dependency 'docopt', '~> 0.5'
  s.add_runtime_dependency 'abstract_method', '~> 1.2'

  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'minitest-reporters', '~> 1.0'
  s.add_development_dependency 'cucumber', '~> 1.3'
  s.add_development_dependency 'aruba', '~> 0.6'
  s.add_development_dependency 'simplecov', '~> 0.9'
end
