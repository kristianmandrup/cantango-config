require 'spec_helper'
require 'cantango/registry/shared/hash_ex'
require 'fixtures/models/project'

CanTango.debug!
connect_db
migrate

class Wheat
end

class Barley
end


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
    
  describe '#actions' do
  end
    
  describe '#available' do
    before do
      orms.register :active_record
    end

    specify { subject.available.should_not be_empty }
    specify { subject.available.should include('Project') }
  end

  describe '#use :guest_user' do
    before do
      subject.use :guest_user
    end
    specify { defined?(CanTango::Model::Guest).should be_true }
  end
  
  describe '#by_reg_exp' do
    it 'should get matching models' do
      pending
      # subject.by_regexp(/Item$/).should include('Item', 'ProductItem')
    end
  end

  describe '#by_category' do
    context 'Category grains wit Wheat and Barley are registered' do
      before do
        CanTango.config.categories.register :grains => ['Wheat', 'Barley']
      end
      
      it 'should find models of :grains' do
        subject.by_category(:grains).should include(Wheat, Barley)
      end

      it 'should not find models of unknown' do
        subject.by_category(:unknown).should be_empty
      end
    end
  end

  describe '#exclude' do
    before do
      subject.exclude 'Item'
    end
    it 'should have Item in excluded list' do
      subject.excluded.should include('Item')
    end

    it 'should exclude Item from available' do
      subject.available.include?('Item').should be_false
    end
  end
end
