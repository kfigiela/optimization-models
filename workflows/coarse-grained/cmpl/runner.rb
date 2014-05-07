#!/usr/bin/env ruby

require_relative 'workflow_problem'

begin 
  Dir.mkdir('outs')
rescue
  # Ignore already if exists
end

problems = []
50.downto(10).each do |deadline|
  run_optimization!("workflow_deadline" => deadline, "storage" => "S3")
  run_optimization!("workflow_deadline" => deadline, "storage" => "CloudFiles")
  # pbs_optimization!("test_pbs", "workflow_deadline" => deadline, "storage" => "S3")
  # pbs_optimization!("test_pbs", "workflow_deadline" => deadline, "storage" => "CloudFiles")
end