require 'spec_helper'

RSpec.describe AgentFetcher, type: :model do
  it 'loads the Agent information for all gems' do
    ade_mock = double()
    expect(ade_mock).to receive(:load_agents).with(no_args).and_return([{'name': 'WebsiteAgent'}])
    expect(ade_mock).to receive(:load_agents).with("huginn_freme_enrichment_agents(github: kreuzwerker/DKT.huginn_freme_enrichment_agents)").and_return([{'name': 'FremeNlpAgent'}])
    expect(AgentDataExtractor).to receive(:new).and_return(ade_mock)
    agent_gem = {name: "huginn_freme_enrichment_agents",
                 repository: "kreuzwerker/DKT.huginn_freme_enrichment_agents"}
    data = AgentFetcher.run([agent_gem])
    expect(data).to eq([agent_gem.merge(agents: []), {agents: [{name: "WebsiteAgent"}]}])
  end
end
