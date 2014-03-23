require_relative '../spec_helper'

describe 'munin-node::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does something' do
    pending 'Your recipe examples goes here.'
  end
end
