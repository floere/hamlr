require 'rubygems'
require 'haml'
require 'sass'
require 'helper'

hamlr = Haml::Engine

haml_processor = lambda {
  infiles = Dir["proto/**/*.haml"]
  
  infiles.each do |infilename|
    outfilename = infilename.gsub(/(^proto)/, 'generated').gsub!(/(\.haml$)/, '')
    
    File.open(outfilename, 'w') do |outfile|
      File.open(infilename, 'r') do |infile|
        outfile.puts hamlr.new(infile.read).render(Helper.new)
      end
    end
  end
}

sassr = Sass::Engine

sass_processor = lambda {
  infiles = Dir["proto/stylesheets/**/*.sass"]
  
  infiles.each do |infilename|
    outfilename = infilename.gsub(/(^proto)/, 'generated').gsub!(/(sass$)/, 'css')
    
    File.open(outfilename, 'w') do |outfile|
      File.open(infilename, 'r') do |infile|
        outfile.puts sassr.new(infile.read).render
      end
    end
  end
}

processing = Thread.new do
  while true
    puts "processing"
    haml_processor[]
    sass_processor[]
    sleep 3
  end
end
processing.join