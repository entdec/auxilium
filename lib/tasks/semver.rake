# frozen_string_literal: true

require 'json'

namespace File.basename(Dir.pwd) do
  desc 'Semantically version and release.\nArguments: PART[=patch] (other options are major and minor)'
  task :semver do
    versions = nil

    gemspec = Dir.glob(File.expand_path(Dir.pwd) + '/*.gemspec').first
    if gemspec
      spec = Gem::Specification.load(gemspec)
      versions = spec.version.to_s
    end

    version_file = Dir.glob(File.expand_path(Dir.pwd) + '/lib/**/version.rb').first
    if version_file
      version_file_content = File.read(version_file)
      versions = version_file_content.scan(/VERSION\s=\s'(.*)'/).flatten.first if versions.nil?
    end

    raise 'Unable to detect version' if versions.nil?

    versions = versions.split('.').map(&:to_i)

    part = ENV['PART'] || 'patch'
    what = %w[ma mi pa].index(part.to_s[0, 2].downcase)
    what ||= 2

    new_version = versions.tap { |parts| parts[what] += 1 }
    new_version = new_version.map.with_index { |v, i| i > what ? 0 : v }.join('.')

    if version_file
      File.open(version_file, 'w') do |file|
        file.puts version_file_content.gsub(/VERSION\s=\s'(.*)'/, "VERSION = '#{new_version}'")
      end

      relative_version_path = Pathname.new(version_file).relative_path_from(Dir.pwd)
      `git add #{relative_version_path}`
    end

    if File.exist?('./package.json')
      package = JSON.parse(File.read('./package.json'))
      package['version'] = new_version
      File.open('./package.json', 'w') do |file|
        file.puts(JSON.pretty_generate(package))
      end

      `git add ./package.json`
    end

    puts "Updated version to #{new_version}"

    `git commit -m "Version #{new_version}"`
    `git push`
    `git tag #{new_version}`
    `git push --tags`
  end
end
