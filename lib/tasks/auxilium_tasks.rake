# frozen_string_literal: true

namespace :auxilium do
  desc 'Release a new version'
  task :release do
    version_file = './lib/auxilium/version.rb'
    File.open(version_file, 'w') do |file|
      file.puts <<~EOVERSION
        # frozen_string_literal: true

        module Auxilium
          VERSION = '#{Auxilium::VERSION.split('.').map(&:to_i).tap { |parts| parts[2] += 1 }.join('.')}'
        end
      EOVERSION
    end
    module Auxilium
      remove_const :VERSION
    end
    load version_file
    puts "Updated version to #{Auxilium::VERSION}"

    # spec = Gem::Specification.find_by_name('auxilium')
    # spec.version = Auxilium::VERSION

    `git commit lib/auxilium/version.rb -m "Version #{Auxilium::VERSION}"`
    `git push`
    `git tag #{Auxilium::VERSION}`
    `git push --tags`
  end
end
