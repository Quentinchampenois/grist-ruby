# frozen_string_literal: true

require_relative "lib/grist/version"

Gem::Specification.new do |spec|
  spec.name = "grist-grist"
  spec.version = Grist::Ruby::VERSION
  spec.authors = ["quentinchampenois"]
  spec.email = ["26109239+Quentinchampenois@users.noreply.github.com"]

  spec.summary = "Ruby client for the Grist API."
  spec.description = "Use this gem to interact with the a Grist API from your Ruby application."
  spec.homepage = "https://github.com/quentinchampenois/grist-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/quentinchampenois/grist-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/quentinchampenois/grist-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
end
