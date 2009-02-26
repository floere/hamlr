require 'rubygems'
require 'haml'
require 'helper'

engine = Haml::Engine

processor = lambda {
  infiles = Dir["proto/**/*.haml"]
  
  infiles.each do |infilename|
    outfilename = infilename.gsub(/(^proto)/, 'generated').gsub!(/(\.haml$)/, '')
    
    File.open(outfilename, 'w') do |outfile|
      File.open(infilename, 'r') do |infile|
        outfile.puts engine.new(infile.read).render(Helper.new)
      end
    end
  end
}

processing = Thread.new do
  while true
    processor[]
    sleep 3
    puts "processing"
  end
end
processing.join