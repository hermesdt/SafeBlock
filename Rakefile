$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "safeblock/version"
 
task :build do
  system "gem build safeblock.gemspec"
end
  
task :release => :build do
  system "gem push safeblock-#{Bunder::VERSION}"
end
