# frozen_string_literal: true

namespace File.basename(Dir.pwd) do
  desc 'Semantically version and release.\nArguments: PART[=patch] (other options are major and minor)'
  task :semver do
    gemspec      = Dir.glob(File.expand_path(Dir.pwd) + '/*.gemspec').first
    version_file = Dir.glob(File.expand_path(Dir.pwd) + '/lib/**/version.rb').first
    spec         = Gem::Specification.load(gemspec)
    part         = ENV['PART'] || 'patch'
    versions     = spec.version.to_s.split('.').map(&:to_i)

    what = %w[ma mi pa].index(part.to_s[0, 2].downcase)
    what ||= 2

    new_version = versions.tap { |parts| parts[what] += 1 }
    new_version = new_version.map.with_index { |v, i| i > what ? 0 : v }.join('.')

    version_file_content = File.read(version_file)
    File.open(version_file, 'w') do |file|
      file.puts version_file_content.gsub(/VERSION\s=\s'(.*)'/, "VERSION = '#{new_version}'")
    end

    puts "Updated version to #{new_version}"

    relative_version_path = Pathname.new(version_file).relative_path_from(Dir.pwd)

    `git commit #{relative_version_path} -m "Version #{new_version}"`
    `git push`
    `git tag #{new_version}`
    `git push --tags`
  end
end