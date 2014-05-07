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

plot = data[:errors].map do |k,v|  
  mean = v.mean
  dev = v.standard_deviation
  v.map {|v| [k, v].join("\t")}.join("\n")
  # [k, mean, mean-dev, v.min, v.max, mean + dev].join("\t")
end.join("\n")  

File.write(file+"-cost-relative.dat", plot)


plot = data[:abs_errors].map do |k,v|  
  mean = v.mean
  dev = v.standard_deviation
  # [k, mean, mean-dev, v.min, v.max, mean + dev].join("\t")
    v.map {|v| [k, v].join("\t")}.join("\n")
end.join("\n")  

File.write(file+"-cost-abs.dat", plot)


plot = data[:max_overrun].map do |k,v|
  # v = vv.select { |o| o > 0.0 }
  mean = v.mean
  dev = v.standard_deviation
  # [k, mean, mean-dev, v.min, v.max, mean + dev].join("\t")
  v.map {|v| [k, v].join("\t")}.join("\n")
end.join("\n")  

File.write(file+"-overrun-abs.dat", plot)

plot = data[:max_overrun].map do |k,vv|
  v = vv.map { |o| o/k.to_f }
  mean = v.mean
  dev = v.standard_deviation
  # [k, mean, mean-dev, v.min, v.max, mean + dev].join("\t")
  v.map {|v| [k, v].join("\t")}.join("\n")  
end.join("\n")  

File.write(file+"-overrun-relative.dat", plot)
