require_relative 'lib/auxilium/version'

Gem::Specification.new do |spec|
  spec.name          = 'auxilium'
  spec.version       = Auxilium::VERSION
  spec.authors       = ['Andre Meij']
  spec.email         = ['andre@itsmeij.com']

  spec.summary       = 'Random utilities.'
  spec.description   = 'Utility classes that are to small to warrant a own gem for now.'
  spec.homepage      = 'https://code.entropydecelerator.com/components/auxilium'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.5')
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://code.entropydecelerator.com/components/auxilium'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack', '> 5.1'
  spec.add_dependency 'activemodel', '> 5.1'
  spec.add_dependency 'activesupport', '> 5.1'
  spec.add_dependency 'pundit', '> 2'
  spec.add_dependency 'responders', '> 3'
  spec.add_dependency 'rolify', '> 5'

  spec.add_development_dependency 'minitest', '> 5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.0'
end
