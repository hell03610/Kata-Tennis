require 'rubygems'
require 'rspec/core/rake_task'

namespace :test do

	desc "Run tests"
	RSpec::Core::RakeTask.new(:all) do |t|
	    t.pattern = "test/*.rb"
	    t.rspec_opts = " -c"
	end


end