#!/usr/bin/env ruby
require 'yaml'
require 'ostruct'
require 'pp'
require 'erb'
require 'fileutils'
require 'monitor'

queue = Dir[ARGV[0]+"/*.yml"]
puts "Queue: #{queue.length} items"
queue.extend MonitorMixin        
threads = 4.times.to_a.map do |tid|
  Thread.new do
    begin                
      IO.popen("/usr/bin/gnuplot", "w") do |gnuplot|
        while input = queue.synchronize { queue.shift }
          puts input
          data = File.open(input, "r") do |f| f.read end
          results = YAML.load data
  
          plt = ""
#           plt << <<-eos
#           puts "Done, saving results"
#           File.open "results/#{config}/results-#{dataSize}.yml", "w" do |f|
#             f.write (YAML.dump({"s3" => results, "cf" => results2}))
#           end
#           
# eos     
        plt << "set title 'Input/output size #{"%4d" % input.match(/(\d+)/)[1]} MiB'\n"
        plt << <<-eos
          set grid
          set autoscale y
          set autoscale y2

          set yrange [0:600]
          set xrange [0:40]
          # 
          

          set xlabel 'Time limit (hours)'
          set ylabel 'Cost ($)'

          plot '-' title 'Amazon S3' ps 1 pt 4, '-' title 'Rackspace Cloud Files' ps 1  pt 6, '-' title 'Optimal' with l  lw 3
          eos
          min = {}
          results["s3"].sort_by { |l| l[0] }.each do |info|
            plt << "#{info[0]}\t#{info[1].total_cost}\n"
            min[info[0]] = info[1].total_cost
          end
          plt << "e\n"
          results["cf"].sort_by { |l| l[0] }.each do |info|
            plt << "#{info[0]}\t#{info[1].total_cost}\n"
            min[info[0]] = info[1].total_cost if info[1].total_cost.to_f < min[info[0]].to_f
          end
          plt << "e\n"
          min.each do |k, v|
            plt << "#{k} #{v}\n"
          end
          plt << "e\n"
          File.open(input.sub("yml","plt"), "w") do |f|
            f.write "#!/usr/bin/env plt\n"
            f.write "set term pdf monochrome font \"Helvetica,9\"\n"
            f.write "set out \"#{input.sub("yml","pdf")}\"\n"
            f.write plt
          end

          gnuplot.write "set term pdf monochrome\n"
          gnuplot.write "set out \"#{input.sub("yml","pdf")}\"\n"
          gnuplot.write plt
          gnuplot.write "set term png size 800,480\n"
          gnuplot.write "set out \"#{input.sub("yml","png")}\"\n"
          gnuplot.write plt
          puts "done"
        end
      end
    rescue Exception => e
      puts "Blad na watku #{tid}: " + e
    end
  end
end
