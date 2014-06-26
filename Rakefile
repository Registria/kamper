require "rubygems"
require "bundler"

Bundler.setup(:default, :test)

task :default => :spec
task :test => :spec

task :spec do
  begin
    require 'spec/rake/spectask'

    desc "Run the specs under spec/"
    Spec::Rake::SpecTask.new do |t|
      t.spec_files = FileList['spec/**/*_spec.rb']
    end
  rescue NameError, LoadError => e
    puts e
  end
end
