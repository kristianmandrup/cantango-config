shared_examples_for 'Hash Registry' do
  describe 'default settings' do
    describe 'defaults' do
      before do
        subject.default = hash1
      end

      its(:default) { should include(hash1) }
    end
  end

  describe 'register' do
    before do
      subject.register hash1
      subject.register hash2
    end
    its(:registered) { should include(hash1) }
    its(:registered) { should include(hash2) }
  end

  describe 'append <<' do
    before do
      subject << hash2
      subject.register hash1
      subject << hash2
    end
    its(:registered) { should include(hash1, hash2) }
  end

  describe 'get index []' do
    before do
      subject.register hash1
      subject << hash2
    end
    
    it 'should respond to :symbol keys' do
      subject[:c].should == hash2[:c]
    end

    it "should respond to 'string' keys" do
      subject['c'].should == hash2[:c]
    end
  end

  describe 'set index []=' do
    before do
      subject.clean!
      subject.register hash1
      subject[:d] = hash2[:c]
    end
    specify { subject[:d].should == hash2[:c] }

  end
end

