shared_examples_for 'Execution Modes' do
  describe 'valid mode=' do
    before do
      subject.mode = :cache
    end
    specify { subject.modes.should == [:cache] }
  end

  describe 'invalid mode=' do
    specify do
      lambda { subject.mode = :cachy! }.should raise_error
    end
  end
end