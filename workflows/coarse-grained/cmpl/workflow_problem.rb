#!/usr/bin/env ruby

require 'bundler/setup'
require 'yaml'
require 'cmpl'

module YAML
  def self.dump_file(data, filename)
    File.open(filename, 'w') do |out|
      YAML.dump(data, out)
    end
  end
end

def schema 
  {
      instances: {
        instance_price: Numeric,
        ccu: Numeric
      },
      providers: {
        provider_max_machines: Numeric,
        transfer_price_in: Numeric,
        transfer_price_out: Numeric,
        instances: DataGenerator::Tuple.new([:instances])
      },
      storages: {
        storages_transfer_price_in: Numeric,
        storages_transfer_price_out: Numeric
      },
      transfer_rate: DataGenerator::Vector.new([:storages, :providers]),
      request_price: Numeric,
      storage_local_rel: DataGenerator::Tuple.new([:storages, :providers]),
      tasks: {
        task_count: Numeric,
        exec_time: Numeric,
        data_size_in: Numeric,
        data_size_out: Numeric
      },
      layers: { 
        tasks: DataGenerator::Tuple.new([:tasks])
      },
      workflow_deadline: Numeric,
      storage: Symbol
  }
end

def run_optimization!(params)
  problem = Problem.new schema, debug: true

  infrastructure = YAML.load_file('infrastructure.yaml')
  workflow = YAML.load_file('workflow.yaml')

  problem.params = infrastructure.merge(workflow).merge(params)

  solution = problem.run!
  result = {solution: solution, params: params}
  YAML.dump_file(result, "outs/#{params.values.join("_").downcase}.yaml")
  File.open("out.txt", 'a') do |out|
    out.puts "%s    %s" % [params.values.map{|v| "%20s" % [v] }.join("\t"), solution.objective.value.inspect]
  end
  return result
end

def pbs_optimization!(dir, params)
  problem = Problem.new schema, debug: true

  infrastructure = YAML.load_file('infrastructure.yaml')
  workflow = YAML.load_file('workflow.yaml')

  problem.params = infrastructure.merge(workflow).merge(params)

  path = dir+"/#{params.values.join("_").downcase}"
  problem.generate_offline_problem(path)
  
  path + "/run.sh"
end