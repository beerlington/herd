#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

desc 'Default: run unit tests.'
task :default => [:spec]

desc 'Test herd'
Rake::TestTask.new(:spec) do |t|
  exec 'rspec'
end
