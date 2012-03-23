# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "toe_core"
  gem.homepage = "http://github.com/pmenke/toe-core"
  gem.license = "MIT"
  gem.summary = %Q{Ruby implementation of the ToE (time-oriented events) data model}
  gem.description = %Q{This is a reference implementation of the ToE (time-oriented events) data model in Ruby. ToE was designed to model multiple heterogeneous event streams resulting from linguistic and psychological experiments.}
  gem.email = "pmenke@googlemail.com"
  gem.authors = ["Peter Menke"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

#require 'rcov/rcovtask'
#Rcov::RcovTask.new do |test|
#  test.libs << 'test'
#  test.pattern = 'test/**/test_*.rb'
#  test.verbose = true
#  test.rcov_opts << '--exclude "gems/*"'
#end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "toe-core #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# pmenke from here on

Bundler.setup(:default, :development)
require 'haml'
require 'benchmark'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'toe-core'

task :benchmark do
  folder = File.dirname(__FILE__) + "/benchmark/"
  docs = {}
  porter = ::ToE::Porter::ToEPorter.new
  
  nums = [10,50,100,500,1000,5000,10000]
  nums.each do |n|
    doc = ::ToE::Gen::RandomDocumentGenerator.instance.generate({ :events => n })
    docs["#{n}"] = doc
    f = File.new(folder+"benchmark_#{n}.toe", "w")
    porter.write(doc, f)
    f.close
  end
  
  nums.each do |num|
    puts docs["#{num}"].describe
    puts ""
    puts "======================="
    #Marshal.dump(docs[num], File.new(folder+"benchmark_#{num}.mar", "w+"))
  end
  
  
  puts ""
  puts "Export to XML"
  Benchmark.bm(9) do |x|
    nums.each do |num|
      x.report("#{num}:") { porter.write(docs["#{num}"], File.new(folder+"benchmark_#{num}.toe", "w")) }
    end
  end
  puts ""
  puts "Import from XML"
    Benchmark.bm(9) do |x|
    nums.each do |num|
      x.report("#{num}:") { ToE::Porter::ToEPorter.read(folder+"benchmark_#{num}.toe", porter) }
    end
  end
  puts ""
  puts "Marshal dump"
  Benchmark.bm(9) do |x|
    nums.each do |num|
      x.report("#{num}:") {
        f = File.new(folder+"benchmark_#{num}.mar", "w")
        Marshal.dump(docs["#{num}"], f)
        f.close
        }
    end
  end
  puts ""
  puts "Marshal load"
  Benchmark.bm(9) do |x|
    nums.each do |num|
      x.report("#{num}:") { Marshal.load(File.new(folder+"benchmark_#{num}.mar", "r")) }
    end
  end  
  
end
