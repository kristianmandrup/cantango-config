class A
end

class B
end

shared_examples_for 'Candidate Registry' do
  let(:hash1) do
    {:a => A, :b => B}
  end

  let(:hash2) do
    {:c => 3}
  end

  describe 'register' do
    before do
      subject.register :a, A
      
    end
    its(:registered) { should include(:a) }
    specify do
      lambda { subject.register :b, 3 }.should raise_error
    end
  end

  describe 'append <<' do
    before do
      subject << hash1
    end
    its(:registered) { should include(*hash1.keys) }
    its(:registered_classes) { should include(*hash1.values) }
    
    specify do
      lambda { subject << hash2 }.should raise_error
    end    
  end

  describe 'set index []=' do
    before do
      subject.clean!
      subject[:a] = B
    end
    its(:registered_classes) { should include(B) }
  end
end

