require 'spec_helper'

class ApplicationController
end

describe CanTango::Config::Helpers do
  subject { CanTango.config.helpers }

  describe 'enable' do
    before do
      subject.enable :rest
    end
    # specify { ::ApplicationController.instance_methods.should include(:link_to_new) }
  end
end
