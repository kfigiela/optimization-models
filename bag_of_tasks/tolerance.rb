#!/usr/bin/env ruby
require 'yaml'
require 'ostruct'
require 'pp'
require 'erb'
require 'fileutils'
require 'monitor'
require 'pry'
require 'yaml'
require 'rubystats'


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

# .sort_by {|f| /(\d+)/.match(f)[1].to_i }
$delta = ARGV[1].to_f
$stderr.puts "Delta +/- = #{$delta/2.0}"
total_exceeded = 0
total_total = 0
total_cost_exceeded = []


class Array
  def avg
    empty? and 0.0 or reduce {|a,b| a+b } / size
  end
end




prices = {'m2.4xlarge' =>        2.40 ,
'm2.2xlarge' =>        1.20 ,
'linux.c1.xlarge' =>   0.68 ,
'm2.xlarge' =>         0.50 ,
'm1.xlarge' =>         0.68 ,
'm1.large' =>          0.34 ,
'c1.medium' =>         0.17 ,
'm1.small' =>          0.085,
'rs-16gb' =>           0.96 ,
'rs-2gb' =>            0.12 ,
'rs-1gb' =>            0.06 ,
'rs-4gb' =>            0.24 ,
'gg-8gb' =>            1.52 ,
'gg-4gb' =>            0.76 ,
'gg-2gb' =>            0.38 ,
'gg-1gb' =>            0.19 ,
'eh-8gb-20gh' =>       0.654,
'eh-4gb-8gh' =>        0.326,
'eh-2gb-4gh' =>        0.164,
'eh-1gb-2gh' =>        0.082,
'private' =>           0    }


$gaussian = Rubystats::NormalDistribution.new(0.0,0.19)  

def truncated_gaussian(mu, sigma, a, b)
  1.0 + $gaussian.icdf($gaussian.cdf(a) + Kernel.rand*($gaussian.cdf(b) - $gaussian.cdf(a)))  
end

def gen_delta 
  truncated_gaussian(0.0, 1.0, -0.5, 0.5)
  # (1.0 + $delta*(Random.rand - 0.5))
end


# def gen_delta 
#   (1.0 + $delta*(Random.rand - 0.5))
# end


errors = Hash.new { |h,k| h[k] = [] }
abs_errors = Hash.new { |h,k| h[k] = [] }
max_overrun = Hash.new { |h,k| h[k] = [] }


Dir[ARGV[0]+"*.yml"].each do |f|
  datasize = /(\d+)/.match(f)[1]
  next if (datasize.to_i % 10) != 0
  
  $stderr.puts f
  data = YAML.load (File.open(f, "r") {|f| f.read })
  
  best = Hash.new { |h,k| h[k] = [] }
  
  (data["s3"]+data["cf"]).sort_by { |l| l[0] }.each do |deadline, allocation|
    best[deadline] << allocation
  end
  
  best.each do |deadline, allocations|
    allocation = allocations.first
    exceeded = 0
    total = 0
    cost = 0.0
    expected_cost = 0.0
    overrun = 0.0
    # puts "@@@@@@@@@@ #{deadline}"
    allocation.instance.each do |instance|
      instance.count.times do |i|
        time = instance.tasks_per_deadline.times.to_a.map { instance.unit_time * gen_delta }.reduce { |a,b| a+b }
        total += 1
        total_total += 1
        cost += prices[instance.name]*time.ceil
        expected_cost += prices[instance.name]*allocation.duration
        # puts "#{time}\t#{allocation.duration}"
        
        overrun = time - allocation.duration if (time - allocation.duration) > overrun
        
        if time > allocation.duration 
          # puts "Time exceeded by #{(time.ceil - allocation.duration)*prices[instance.name]}"
          exceeded += 1
          total_exceeded += 1
        else
        # exceeded_arr[deadline] << time - allocation.duration
          # puts "Time not exceeded"
        end
      end

      time = ((instance.tasks - instance.tasks_per_deadline*instance.count).times.to_a.map { instance.unit_time * gen_delta }.reduce { |a,b| a+b } || 0)
      cost += prices[instance.name]*time.ceil
      expected_cost += prices[instance.name]*instance.tail
      
      if time > instance.tail
        exceeded += 1
        total_exceeded += 1        
        # puts "Time exceeded by #{time - instance.tail}"
      end
      # exceeded_arr[deadline] << time - instance.tail        
      overrun = time - allocation.duration if (time - allocation.duration) > overrun
      max_overrun[deadline] << overrun
    end
    puts "#{deadline} cost=#{cost} expected=#{expected_cost} total=#{allocation.total_cost} relative=#{(cost-expected_cost)/allocation.total_cost} "
    # puts "#{deadline} #{'%2.2f%' % [100*((cost-expected_cost)/allocation.total_cost)]}"
    errors[deadline] << ((cost-expected_cost)/allocation.total_cost)
    abs_errors[deadline] << ((cost-expected_cost))
    total_cost_exceeded << ((cost-expected_cost)/allocation.total_cost)
  end
  
end
puts "# total exceeded #{total_exceeded} of #{total_total}"
puts "# avg #{(total_cost_exceeded.reduce{|a,b| a+b}/total_cost_exceeded.count)*100}"
puts "# mapax #{total_cost_exceeded.max*100}"
# 
# errors.each do |deadline, errors| 
#   puts "#{deadline} #{errors.avg}"
# end

print YAML.dump({errors: errors, abs_errors: abs_errors, max_overrun: max_overrun})

__END__


#!/usr/bin/env ruby
require 'yaml'
require 'ostruct'
require 'pp'
require 'erb'
require 'fileutils'
require 'monitor'
require 'pry'
require 'yaml'
require 'rubystats'


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

# .sort_by {|f| /(\d+)/.match(f)[1].to_i }
$delta = ARGV[1].to_f
$stderr.puts "Delta +/- = #{$delta/2.0}"
total_exceeded = 0
total_total = 0
total_cost_exceeded = []


class Array
  def avg
    empty? and 0.0 or reduce {|a,b| a+b } / size
  end
end




prices = {'m2.4xlarge' =>        2.40 ,
'm2.2xlarge' =>        1.20 ,
'linux.c1.xlarge' =>   0.68 ,
'm2.xlarge' =>         0.50 ,
'm1.xlarge' =>         0.68 ,
'm1.large' =>          0.34 ,
'c1.medium' =>         0.17 ,
'm1.small' =>          0.085,
'rs-16gb' =>           0.96 ,
'rs-2gb' =>            0.12 ,
'rs-1gb' =>            0.06 ,
'rs-4gb' =>            0.24 ,
'gg-8gb' =>            1.52 ,
'gg-4gb' =>            0.76 ,
'gg-2gb' =>            0.38 ,
'gg-1gb' =>            0.19 ,
'eh-8gb-20gh' =>       0.654,
'eh-4gb-8gh' =>        0.326,
'eh-2gb-4gh' =>        0.164,
'eh-1gb-2gh' =>        0.082,
'private' =>           0    }

$gaussian = Rubystats::NormalDistribution.new(0.0,1.0)  

def truncated_gaussian(mu, sigma, a, b)
  1.0 + $gaussian.icdf($gaussian.cdf(a) + Kernel.rand*($gaussian.cdf(b) - $gaussian.cdf(a)))  
end

def gen_delta 
  truncated_gaussian(0.0, 1.0, -0.5, 0.5)
  # (1.0 + $delta*(Random.rand - 0.5))
end

errors = Hash.new { |h,k| h[k] = [] }
Dir[ARGV[0]+"/*.yml"].each do |f|
  # datasize = /(\d+)/.match(f)[1]
  $stderr.puts f
  data = YAML.load (File.open(f, "r") {|f| f.read })
  
  best = Hash.new { |h,k| h[k] = [] }
  
  (data["s3"]+data["cf"]).sort_by { |l| l[0] }.each do |deadline, allocation|
    best[deadline] << allocation
  end
  
  best.each do |deadline, allocations|
    allocation = allocations.first
    exceeded = 0
    total = 0
    cost = 0.0
    expected_cost = 0.0
    # puts "@@@@@@@@@@ #{deadline}"
    allocation.instance.each do |instance|
      instance.count.times do |i|
        time = instance.tasks_per_deadline.times.to_a.map { instance.unit_time * gen_delta }.reduce { |a,b| a+b }
        total += 1
        total_total += 1
        cost += prices[instance.name]*time.ceil
        expected_cost += prices[instance.name]*allocation.duration
        # puts "#{time}\t#{allocation.duration}"
        if time > allocation.duration 
          # puts "Time exceeded by #{(time.ceil - allocation.duration)*prices[instance.name]}"
          exceeded += 1
          total_exceeded += 1
        else
          # puts "Time not exceeded"
        end
      end

      time = ((instance.tasks - instance.tasks_per_deadline*instance.count).times.to_a.map { instance.unit_time * gen_delta }.reduce { |a,b| a+b } || 0)
      cost += prices[instance.name]*time.ceil
      expected_cost += prices[instance.name]*instance.tail
      
      if time > instance.tail
        exceeded += 1
        total_exceeded += 1        
        # puts "Time exceeded by #{time - instance.tail}"
      end
    end
    # puts "#{deadline} cost=#{cost} expected=#{expected_cost}"
    # puts "#{deadline} #{'%2.2f%' % [100*((cost-expected_cost)/allocation.total_cost)]}"
    errors[deadline] << ((cost-expected_cost)/allocation.total_cost)
    total_cost_exceeded << ((cost-expected_cost)/allocation.total_cost)
  end
  
end
puts "# total exceeded #{total_exceeded} of #{total_total}"
puts "# avg #{(total_cost_exceeded.reduce{|a,b| a+b}/total_cost_exceeded.count)*100}"
puts "# mapax #{total_cost_exceeded.max*100}"
# 
# errors.each do |deadline, errors| 
#   puts "#{deadline} #{errors.avg}"
# end

print YAML.dump(errors)