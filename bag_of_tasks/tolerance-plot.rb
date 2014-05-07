#!/usr/bin/env ruby
require 'yaml'

module Enumerable
    def sum
      self.inject(0){|accum, i| accum + i }
    end

    def mean
      self.sum/self.length.to_f
    end

    def sample_variance
      m = self.mean
      sum = self.inject(0){|accum, i| accum +(i-m)**2 }
      sum/(self.length - 1).to_f
    end

    def standard_deviation
      return Math.sqrt(self.sample_variance)
    end

end 

file = ARGV[0]

data = YAML.load(File.read(file))

plot = data.map do |k,v|
  mean = v.mean
  dev = v.standard_deviation
  [k, mean, mean-dev, v.min, v.max, mean + dev].join("\t")
end.join("\n")  

File.write(file+".dat", plot)