require 'spec_helper'

RSpec.describe GemspecParser, type: :model do
  it 'parses a gemspec file' do
    gemspec = GemspecParser.parse(load_data('data/huginn_lifx_agents.gemspec'))
    expect(gemspec).to eq(name: "huginn_lifx_agents",
                          summary: "Huginn agents to interact with your LIFX light blubs",
                          description: "Huginn agents to interact with your LIFX light blubs",
                          homepage: "https://huginn.omniscope.io/",
                          license: "MIT",
                          add_runtime_dependency: ["huginn_agent", "omniauth-lifx"],
                          add_development_dependency: %w(bundler rake rspec))
  end
end
