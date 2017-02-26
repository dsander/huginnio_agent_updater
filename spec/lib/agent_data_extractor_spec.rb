require 'spec_helper'

RSpec.describe AgentDataExtractor, type: :model do
  let(:extractor) { AgentDataExtractor.new }

  context '#load_agents' do
    it 'rescues from ExtractionException' do
      allow(extractor).to receive(:puts)
      expect(extractor).to receive(:bundle).and_raise(AgentDataExtractor::ExtractionException)
      expect(extractor.load_agents('test')).to eq([])
    end
  end
end
