$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chinese_holiday/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chinese_holiday"
  s.version     = ChineseHoliday::VERSION
  s.authors     = ["zhuxiaoyu"]
  s.email       = ["dodocat6666@hotmail.com"]
  s.homepage    = "https://github.com/shawndodo/chinese_holiday"
  s.summary     = %q{Manage Chinese Calendar}
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2", "< 6.0"

  s.add_development_dependency "sqlite3"
end
