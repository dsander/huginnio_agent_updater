lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'agent_updater'
require "rspec/core/rake_task"
require 'dotenv'
Dotenv.load

RSpec::Core::RakeTask.new(:spec)

desc "Update Huginn Agents and Agent Gems on Huginn.io"
task :update do
  data = AgentFetcher.run

  puts "Uploading data to Huginn.io ..."
  uri = URI("http://huginnio.herokuapp.com/webhook/import_agents")
  req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  req.body = {data: data, token: ENV['API_TOKEN']}.to_json

  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end

  fail res.inspect unless res.code == "200"
end

task default: :spec
