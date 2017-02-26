require 'json'

class AgentFetcher
  class <<self
    def run(gem_data = AgentGemFetcher.run)
      data_extractor = AgentDataExtractor.new
      data_extractor.prepare

      huginn_agents = data_extractor.load_agents
      huginn_agent_names = huginn_agents.map { |agent| agent['name'] }

      gem_data.map do |data|
        gem_agents = data_extractor.load_agents("#{data[:name]}(github: #{data[:repository]})")
                                   .reject { |agent| huginn_agent_names.include?(agent['name']) }
        data[:agents] = gem_agents
        data
      end.push(agents: huginn_agents)
    end
  end
end
