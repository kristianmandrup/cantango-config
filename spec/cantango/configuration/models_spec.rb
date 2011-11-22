require 'spec_helper'
require 'cantango/configuration/shared/hash_registry_ex'
require 'fixtures/models/project'

CanTango.debug!
connect_db
migrate

describe CanTango::Configuration::Models do
  let(:models) { CanTango.config.models }
  let(:orms) { CanTango.config.orms }
  
  it_should_behave_like "Hash Registry" do
    subject { models.actions }
    
    let(:hash1) do
      {:a => 1, :b => 2}
    end
    
    let(:hash2) do
      {:c => 3}
    end
  end
  
  subject { models } 
    
  describe 'available_models' do
    before do
      orms.register :active_record
    end

    specify { subject.available_models.should_not be_empty }
    specify { subject.available_models.should include('Project') }
  end
  
  describe 'by_reg_exp' do
  end

  describe 'by_category' do
  end

  describe 'exclude' do
  end

  describe 'excluded' do
  end
end
