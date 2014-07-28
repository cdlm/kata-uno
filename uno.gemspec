Gem::Specification.new do |s|
  s.name        = 'uno'
  s.version     = '0.0.0'
  s.date        = '2014-07-28'
  s.summary     = "Uno rules checker"
  s.description = <<-DESCRIPTION
A rule checker for the cards game Uno

This is a reference implementation for a Java programming assignment.
DESCRIPTION
  s.authors     = ["Damien Pollet"]
  s.email       = 'damien.pollet@telecom-lille.fr'
  # s.homepage    = ''
  s.license     = 'MIT'

  s.files       = Dir["lib/**/*.rb"]
  s.executables << 'uno'

  s.add_runtime_dependency 'docopt'
end
