# Workflow planner optimization model

## What is where?

* Infrastructure description is `infrastructure.yaml`
* Workflow description is `workflow.yaml`
* Optimization model is in `workflow.cmpl`

## How to run?

* Install ruby >= 2.0 and bundler
* `bundle install`
* `./runner.rb` - this script iterates over some range of deadlines to find the best solution
